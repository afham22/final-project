import sqlscripts as sqls,computations as comp
# Using flask to make an api
# import necessary libraries and functions
from flask import Flask, jsonify, request, make_response
#import config
#import jwt

# creating a Flask app
app = Flask(__name__)

#--Creating userrecord table--
sqls.create_user_records_table()


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
	sqls.insert_value(firstname, lastname, email, password, gender,dob, jobtitle, city)
	return firstname + lastname


@app.route('/login', methods = ['POST'])
def login():
	data = request.get_json()

	pass1 = 'test1234'

	email = data['email']
	password = data['password']

	if password == pass1:
		return 'Success', 200
	else:
		return 'Invalid password', 401






@app.route('/PPPCalculation', methods = ['GET'])
def PPPCalc():
	return 'OOK'


@app.route('/DemoCompare', methods = ['GET'])
def demoCompare():
	return 'Hello'



# A simple function to calculate the square of a number
# the number to be squared is sent in the URL when we use GET
# on the terminal type: curl http://127.0.0.1:5000 / home / 10
@app.route('/login', methods = ['POST'])
def disp(num):

	return jsonify({'data': num**2})


# def jwtTokenizer():
# 	return jwt.encode({'some': 'payload'},config('SECRET_KEY'), algorithm='RS256')



# driver function
if __name__ == '__main__':

	app.run(debug = True)
