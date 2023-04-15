import sqlscripts as sqls,tokenjwt as jt,computations as comp

from flask import Flask, jsonify, request, make_response

import jwt
from decouple import config
app = Flask(__name__)

#--Creating userrecord table--
# sqls.create_user_records_table()

def auth_required(endpoint_name):
    def decorated(view_func):
        def wrapper(*args, **kwargs):
            auth_header = request.headers.get('Authorization')
            if not auth_header:
                return jsonify({'message': 'Authorization header is missing'}), 401
            # Extract the token from the header
            token = auth_header.split(' ')[1]
            try:
                # Verify the token
                payload = jwt.decode(token, jt.public_key, algorithms=['RS256'])
            except jwt.InvalidTokenError:
                return jsonify({'message': 'Invalid token'}), 401

            # Add the decoded token to the request context
            request.decoded_token = payload
            return view_func(*args, **kwargs)

        wrapper.__name__ = view_func.__name__
        wrapper.__doc__ = view_func.__doc__
        wrapper.__module__ = view_func.__module__

        app.add_url_rule('/' + endpoint_name, view_func=wrapper)
        return wrapper

    return decorated


def handle_errors(f):
    def wrapper(*args, **kwargs):
        try:
            return f(*args, **kwargs)
        except Exception as e:
            response = {
                'status_code': 500,
                'status': 'Internal Server Error',
                'message': str(e)
            }
            return jsonify(response), 500
    wrapper.__name__ = f.__name__
    return wrapper


@app.route('/createaccount', methods = ['POST'])
@handle_errors
def createaccount():
	data = request.get_json()
	firstname = data['firstname']
	lastname = data['lastname']
	email = data['email']
	password = data['password']
	gender = data['gender']
	dob = data['dob']
	jobtitle = data['jobtitle']
	city = data['city']
	income=data['income']
	user_id,lastname=sqls.createAccount(firstname, lastname, email, password, gender,dob, jobtitle, income,city)
	sqls.create_user_expense_table(user_id,lastname)
	return 'Account created successfully',200


@app.route('/login', methods = ['POST'])
@handle_errors
def login():
	data = request.get_json()
	email = data['email']
	password = data['password']
	item=sqls.check_password(email)
	if item==None:
		return 'User does not exist'
	elif password == item[0]:
		payload = {'user_id':item[1],'lastname':item[2]}
		token=jwt.encode(payload,jt.private_key, algorithm='RS256')
		return jsonify({'token':token})
	else:
		return 'Invalid password', 401

@app.route('/PPPCalculation', methods = ['GET'])
@auth_required('PPPCalculation')
@handle_errors
def PPPCalc():
	user_id = request.decoded_token.get('user_id')
	lastname = request.decoded_token.get('lastname')
	data = request.get_json()
	city = data['city']
	category_list = sqls.getExpense(user_id,lastname)

	res= comp.PPP(category_list, city)
	return res

@app.route('/DemoCompare', methods = ['GET'])
@auth_required('DemoCompare_auth')
@handle_errors
def demoCompare():
	user_id = request.decoded_token.get('user_id')
	data=sqls.demo(user_id)
	age=data[4]
	income=data[3]
	job_title=data[1]
	gender=data[0]
	city=data[2]

	pred=comp.evaluate(age,income,job_title,gender,city)
	return jsonify({'Housing':str (pred[0]),
		 'Groceries':str (pred[1]),
		 'Entertainment':str (pred[2]),
		 'Leisure':str (pred[3]),
		 'Transportation':str (pred[4]),
		 'Medical':str (pred[5]),
		 'Utilities':str (pred[6]),
		 'Insurance':str (pred[7])
		 })


@app.route('/insertTransac', methods = ['POST'])
@auth_required('insertTransac')
@handle_errors
def insertTransac():
	user_id = request.decoded_token.get('user_id')
	lastname = request.decoded_token.get('lastname')
	data=request.get_json()
	tid=data['tid']
	date=data['date']
	category=data['category']
	amount=data['amount']
	sqls.insert_value_trans(tid,date,category,amount,lastname,user_id)
	return 'Transaction inserted successfully'


@app.route('/checkEmail', methods = ['POST'])
@handle_errors
def checkEmail():
	data = request.get_json()
	email = data['email']
	if sqls.check_email(email)==False:
		return '', 200
	else:
		return 'Email Exist', 403

if __name__ == '__main__':

	app.run(debug = True)
