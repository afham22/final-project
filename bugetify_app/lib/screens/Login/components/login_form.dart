import 'dart:convert';
import 'package:bugetify_app/app_homePage.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginForm> {
  String _token = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<String> getToken() async {
    var url = Uri.parse('http://192.168.1.13:5000/login');

    final response = await post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'password': passwordController.text
      }),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['token'];
    } else {
      throw Exception('verification failed');
    }
  }

  Future<void> _login() async {
    final String token = await getToken();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    setState(() {
      _token = token;
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AppHome()));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.always,
        child: Stack(children: [
          Column(
            children: [
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
                  hintText: "Your email",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  cursorColor: Color(0xFF6F35A5),
                  decoration: InputDecoration(
                    hintText: "Your password",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Hero(
                tag: "login_btn",
                child: ElevatedButton(
                  onPressed: _login
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => AppHome()));
                  ,
                  child: Text(
                    "Login".toUpperCase(),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ]));
  }
}
