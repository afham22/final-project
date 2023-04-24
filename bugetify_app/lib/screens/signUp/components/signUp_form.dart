import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class signUpForm extends StatefulWidget {
  signUpForm({
    Key? key,
  }) : super(key: key);

  @override
  _signUpFormState createState() => _signUpFormState();
}

class _signUpFormState extends State<signUpForm> {
  String? _gender;
  final _passwordController = TextEditingController();

  String _selectedLocation = 'Bangalore';
  String _selectedJob = 'Accountant';

  final List<String> _locations = [
    'Bangalore',
    'Mumbai',
    'Delhi',
    'Kochi',
    'Raipur'
  ];
  final List<String> _Job = [
    'Accountant',
    'Clerk',
    'Software developer',
    'Doctor',
    'Teaching faculty'
  ];

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController incomeController = TextEditingController();

  TextEditingController _date = TextEditingController();

  void signup(String firstname, lastname, email, password, gender, dob, job,
      income, city) async {
    try {
      var url = Uri.parse('http://192.168.0.106:5000/login');

//here is The Error occur at http.get(url),

      Response response = await post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
          'password': password,
          'gender': gender,
          'dob': dob,
          'jobtitle': job,
          'income': income,
          'city': city
        }),
      );
      if (response.statusCode == 200) {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => AppHome()));
      } else {
        print('verification failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40.0),
          TextFormField(
            controller: firstnameController,
            textInputAction: TextInputAction.next,
            obscureText: false,
            cursorColor: Color(0xFF6F35A5),
            decoration: InputDecoration(
              hintText: "Enter your first name",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.person),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: lastnameController,
            textInputAction: TextInputAction.next,
            obscureText: false,
            cursorColor: Color(0xFF6F35A5),
            decoration: InputDecoration(
              hintText: "Enter your last name",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.person),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) => EmailValidator.validate(value)
                ? null
                : "Please enter a valid email",
            cursorColor: Color(0xFF6F35A5),
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Enter your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.email),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.next,
            obscureText: true,
            cursorColor: Color(0xFF6F35A5),
            decoration: InputDecoration(
              hintText: "Enter a password",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.lock),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            textInputAction: TextInputAction.done,
            obscureText: true,
            cursorColor: Color(0xFF6F35A5),
            decoration: InputDecoration(
              hintText: "Re-enter your password",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.lock),
              ),
            ),
            validator: (value) {
              final password = passwordController.text;
              if (value != password) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: incomeController,
            textInputAction: TextInputAction.next,
            obscureText: false,
            cursorColor: Color(0xFF6F35A5),
            decoration: InputDecoration(
              hintText: "Enter your Income",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.money),
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints
                    .maxWidth, // Set the width to the maximum available width
                height: 70, // Set the desired height constraint
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InputDecorator(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: DropdownButton(
                          value: _selectedLocation,
                          items: _locations.map((location) {
                            return DropdownMenuItem(
                              value: location,
                              child: Text(
                                location,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black54,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedLocation = value.toString();
                            });
                          },
                          underline: Container(
                            height: 0,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints
                    .maxWidth, // Set the width to the maximum available width
                height: 70, // Set the desired height constraint
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InputDecorator(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: DropdownButton(
                          value: _selectedJob,
                          items: _Job.map((Job) {
                            return DropdownMenuItem(
                              value: Job,
                              child: Text(
                                Job,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black54,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedJob = value.toString();
                            });
                          },
                          underline: Container(
                            height: 0,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: 16,
          ),
          TextField(
            controller: _date,
            // textInputAction: TextInputAction.next,
            // obscureText: false,
            cursorColor: Color(0xFF6F35A5),
            decoration: InputDecoration(
              hintText: "Select date",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.calendar_today_rounded),
              ),
            ),
            onTap: () async {
              DateTime? pickdate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now());
              if (pickdate != null) {
                setState(() {
                  _date.text = DateFormat('yyyy-MM-dd').format(pickdate);
                });
              }
            },
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Text(
                'Gender:',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: 0),
                        title: Text(
                          'M',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                        value: 'male',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: 0),
                        title: Text(
                          'F',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                        value: 'female',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: 0),
                        contentPadding:
                            EdgeInsets.zero, // Set contentPadding to zero

                        title: Text(
                          'Other',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                        value: 'other',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 2),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          Hero(
            tag: "signUp_btn",
            child: ElevatedButton(
              onPressed: () {
                // signup(
                //     firstnameController.toString(),
                //     lastnameController.toString(),
                //     emailController.text.toString(),
                //     passwordController.text.toString(),
                //     _gender.toString(),
                //     _Job.toString(),
                //     incomeController.toString(),
                //     _locations.toString());
              },
              child: Text(
                "Sign Up".toUpperCase(),
              ),
            ),
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
