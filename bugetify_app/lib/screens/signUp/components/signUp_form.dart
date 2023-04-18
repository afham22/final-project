import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16.0),
          TextFormField(
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
              final password = _passwordController.text;
              if (value != password) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
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
          SizedBox(height: 10),
          Hero(
            tag: "signUp_btn",
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Sign Up".toUpperCase(),
              ),
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
