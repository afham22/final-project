import sqlscripts as sqls,tokenjwt as jt,computations as comp
import logging,jwt,requests
from flask import Flask, jsonify, request, make_response
from decouple import config
from apscheduler.schedulers.background import BackgroundScheduler
from apscheduler.triggers.cron import CronTrigger

app = Flask(__name__)
scheduler = BackgroundScheduler(daemon=True)

#Logger Configuration
log = logging.getLogger('myapp')
log.setLevel(logging.DEBUG)
fh = logging.FileHandler('myapp.log')
fh.setLevel(logging.DEBUG)
log.addHandler(fh)

gold_price=0
dollar=0
def get_dollar():
    try:
        global dollar
        response = requests.get("https://openexchangerates.org/api/latest.json?app_id=96ad967e6fc7479a8eff532d1b8cdce4&symbols=INR")
        if response.status_code == 200:
            data = response.json()
            rates = data['rates']
            for key,values in rates.items():
                dollar=values
    except Exception as e:
            log.exception('An error occured: %s',str(e))

def get_gold_price():
    global gold_price
    try:
        response = requests.get("https://metals-api.com/api/latest?access_key=qyu5mrfh5kb3b7m97h3xp5bxua02o9upzt294nq16k1q8qiowqgm5tm1fchz&base=INR&symbols=XAU")
        if response.status_code == 200:
            data = response.json()
            rates = data['rates']
            for key,values in rates.items():
                gold_price=values/28.3495
    except Exception as e:
            log.exception('An error occured: %s',str(e))
                

scheduler.add_job(get_dollar, trigger=CronTrigger.from_crontab('14 17 * * *'))
scheduler.add_job(get_gold_price, trigger=CronTrigger.from_crontab('14 17 * * *'))
# scheduler.add_job(sqls.check_email, trigger=CronTrigger.from_crontab('06 17 * * *'))


# --Creating userrecord table--
sqls.create_user_records_table()

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


@app.route('/init', methods = ['GET'])
@auth_required('insertTransac')
@handle_errors
def init():
	user_id = request.decoded_token.get('user_id')
	lastname = request.decoded_token.get('lastname')
	return jsonify({'gold':gold_price,'dollar':dollar})


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
	scheduler.start()
	app.run(debug = True)
