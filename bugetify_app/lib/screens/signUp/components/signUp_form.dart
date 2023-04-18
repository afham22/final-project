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
          Row(
            children: [
              Text('Gender:'),
              SizedBox(width: 8),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: 0),
                        title: Text('M'),
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
                        title: Text('F'),
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

                        title: Text('Other'),
                        value: 'other',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
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
