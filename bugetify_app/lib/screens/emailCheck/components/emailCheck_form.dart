import 'dart:convert';

import 'package:bugetify_app/screens/Signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart';

class emailCheckForm extends StatefulWidget {
  const emailCheckForm({
    Key? key,
  }) : super(key: key);

  @override
  _CheckEmailState createState() => _CheckEmailState();
}

class _CheckEmailState extends State<emailCheckForm> {
  TextEditingController checkEmailController = TextEditingController();

  void checkEmail(String email) async {
    try {
      var url = Uri.parse('http://localhost:5000/checkEmail');

//here is The Error occur at http.get(url),

      Response response = await post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );
      if (response.statusCode == 200) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => signUpScreen()));
      } else {
        print('verification failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          TextFormField(
            controller: checkEmailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) => EmailValidator.validate(value)
                ? null
                : "Please enter a valid email",
            cursorColor: Color(0xFF6F35A5),
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: 16.0 / 2),
          ElevatedButton(
            onPressed: () {
              checkEmail(checkEmailController.text.toString());
            },
            child: Text("Verify Email".toUpperCase()),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
