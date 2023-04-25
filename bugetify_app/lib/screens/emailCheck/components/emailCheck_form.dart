import 'dart:convert';
import 'package:bugetify_app/screens/Signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// final storage = FlutterSecureStorage();

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
    // final jwtToken = await storage.read(key: 'jwt_token');

    try {
      var url = Uri.parse('http://192.168.1.12:5000/checkEmail');

      Response response = await post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'email': email}),
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
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => signUpScreen()));
            },
            child: Text("Verify Email".toUpperCase()),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
