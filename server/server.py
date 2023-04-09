import sqlscripts as sqls,tokenjwt as jt
# Using flask to make an api
# import necessary libraries and functions
from flask import Flask, jsonify, request, make_response
#import config
#import jwt
import jwt
from decouple import config
# creating a Flask app
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




# on the terminal type: curl http://127.0.0.1:5000/
# returns hello world when we use GET.
# returns the data that we send when we use POST.
@app.route('/createaccount', methods = ['POST'])
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
	user_id,lastname=sqls.createAccount(firstname, lastname, email, password, gender,dob, jobtitle, city)
	payload = {'user_id':user_id,'lastname':lastname}
	token=jwt.encode(payload,jt.private_key, algorithm='RS256')
	sqls.create_user_expense_table(user_id,lastname)
	return jsonify({'token':token})


@app.route('/login', methods = ['POST'])
def login():
	data = request.get_json()	
	email = data['email']
	password = data['password']
	# checkpass=sqls.check_password(email)
	# if password == checkpass:
	return 'Success', 200
	# else:
	# 	return 'Invalid password', 401

@app.route('/PPPCalculation', methods = ['GET'])
@auth_required('PPPCalculation')
def PPPCalc():
	return 'OOK'

# @app.route('/DemoCompare', methods = ['GET'])
# @auth_required('DemoCompare_auth')
# def demoCompare():
# 	data=request.get_json()
# 	age=data['age']
# 	income=data['income']
# 	job_title=data['job_title']
# 	gender=data['gender']
# 	city=data['city']

# 	pred=comp.evaluate(age,income,job_title,gender,city)
# 	return jsonify({'Housing':str (pred[0]),
# 		 'Groceries':str (pred[1]),
# 		 'Entertainment':str (pred[2]),
# 		 'Leisure':str (pred[3]),
# 		 'Transportation':str (pred[4]),
# 		 'Medical':str (pred[5]),
# 		 'Utilities':str (pred[6]),
# 		 'Insurance':str (pred[7])
# 		 })
	


@app.route('/insertTransac', methods = ['POST'])
@auth_required('insertTransac')
def insertTransac():
	# user_id = request.decoded_token.get('user_id')
	# data=request.get_json()
	# tid=data['tid']
	# date=data['date']
	# category=data['category']
	# amount=data['amount']
	# sqls.insert_into_transac(user_id,tid,date,category,amount)
	return 'Transaction inserted successfully'


@app.route('/checkEmail', methods = ['POST'])
def checkEmail():
	data = request.get_json()
	email = data['email']

	if email == 'test1@test1.com':
		return 'Email Exists', 403
	else:
		return '', 200

# A simple function to calculate the square of a number
# the number to be squared is sent in the URL when we use GET
# on the terminal type: curl http://127.0.0.1:5000 / home / 10
# @app.route('/login', methods = ['POST'])
# def disp(num):

# 	return jsonify({'data': num**2})



@app.route('/token', methods = ['POST'])
@auth_required('token_auth')
def token():
	user_id = request.decoded_token.get('user_id')
	lastname = request.decoded_token.get('lastname')

	# a=jwt.encode({'user_id': '1234'},jt.private_key, algorithm='RS256')
	# print(a)
	# b=jwt.decode(a,jt.public_key, algorithms=["RS256"])
	# print(b)
	return jsonify({'id':user_id,'lastname':lastname})
# driver function
if __name__ == '__main__':

	app.run(debug = True)
