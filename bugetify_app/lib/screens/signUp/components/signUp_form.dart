import 'dart:convert';

import 'package:bugetify_app/app_homePage.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class signUpForm extends StatefulWidget {
  TextEditingController emailController = TextEditingController();

  signUpForm(this.emailController);

  @override
  _signUpFormState createState() => _signUpFormState();
}

class _signUpFormState extends State<signUpForm> {
  String? _gender = 'male';

  TextEditingController _password = TextEditingController();
  TextEditingController _verifyPassword = TextEditingController();
  bool _isPasswordMatched = false;

  void _submitPassword(password, verifyPassword) {
    if (password.text.toString() == verifyPassword.text.toString() &&
        _password.text.isNotEmpty &&
        _verifyPassword.text.isNotEmpty) {
      setState(() {
        _isPasswordMatched = true;
      });
    } else {
      setState(() {
        _isPasswordMatched = false;
      });
    }
  }

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

  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController incomeController = TextEditingController();

  TextEditingController _date = TextEditingController();
  bool _isError1 = false;
  bool _isError2 = false;
  bool _ismin1 = true;
  bool _ismin2 = true;

  void _validateText(_textEditingController) {
    if (_textEditingController.text.isEmpty) {
      setState(() {
        _ismin1 = true;
      });
    } else if (_textEditingController.text.length > 15) {
      setState(() {
        _isError1 = true;
      });
    } else if (!_textEditingController.text.contains(RegExp(r'^[a-zA-Z]+$'))) {
      setState(() {
        _isError1 = true;
      });
    } else {
      setState(() {
        _isError1 = false;
        _ismin1 = false;
      });
    }
  }

  void _vaalidateText(_textEditingController) {
    if (_textEditingController.text.isEmpty) {
      setState(() {
        _ismin2 = true;
      });
    } else if (_textEditingController.text.length > 15) {
      setState(() {
        _isError2 = true;
      });
    } else if (!_textEditingController.text.contains(RegExp(r'^[a-zA-Z]+$'))) {
      setState(() {
        _isError2 = true;
      });
    } else {
      setState(() {
        _isError2 = false;
        _ismin2 = false;
      });
    }
  }

  void signup(String firstname, lastname, email, password, gender, dob, job,
      income, city) async {
    try {
      if (!_isError1 &&
          !_isError2 &&
          !_ismin1 &&
          !_ismin2 &&
          _isPasswordMatched) {
        var url = Uri.parse('http://192.168.1.13/createaccount');

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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AppHome()));
        }
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
            onChanged: (_) => _validateText(firstnameController),
            textInputAction: TextInputAction.next,
            obscureText: false,
            cursorColor: Color(0xFF6F35A5),
            decoration: InputDecoration(
              hintText: "Enter your first name",
              errorText: (_isError1
                  ? 'Only upto 15 alphabetic charcters allowed'
                  : _ismin1
                      ? 'Enter your firstname'
                      : null),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.person),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]+$')),
            ],
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: lastnameController,
            onChanged: (_) => _vaalidateText(lastnameController),
            textInputAction: TextInputAction.next,
            obscureText: false,
            cursorColor: Color(0xFF6F35A5),
            decoration: InputDecoration(
              hintText: "Enter your last name",
              errorText: _isError2
                  ? 'Only upto 15 alphabetic charcters allowed'
                  : _ismin2
                      ? 'Enter your second name'
                      : null,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.person),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]+$')),
            ],
          ),
          SizedBox(height: 16.0),
          TextFormField(
            readOnly: true,
            initialValue: widget.emailController.text,
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
            controller: _password,
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
            controller: _verifyPassword,
            obscureText: true,
            cursorColor: Color(0xFF6F35A5),
            decoration: InputDecoration(
              hintText: "Re-enter your password",
              errorText: !_isPasswordMatched ? 'Password not matched' : null,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.lock),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: incomeController,
            textInputAction: TextInputAction.next,
            obscureText: false,
            keyboardType: TextInputType.number,
            cursorColor: Color(0xFF6F35A5),
            decoration: InputDecoration(
              hintText: "Enter your Income",
              errorText:
                  incomeController.text.isEmpty ? 'Enter your income' : null,
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
                _submitPassword(_password, _verifyPassword);
                signup(
                    firstnameController.text.toString(),
                    lastnameController.text.toString(),
                    widget.emailController.text.toString(),
                    passwordController.text.toString(),
                    _gender.toString(),
                    _date.text,
                    _selectedJob.toString(),
                    incomeController.text.toString(),
                    _selectedLocation.toString());
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
