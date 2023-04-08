import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

String? gender;

class signUpForm extends StatelessWidget {
  const signUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.always,
        child: Stack(children: [
          Column(
            children: [
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
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  cursorColor: Color(0xFF6F35A5),
                  decoration: InputDecoration(
                    hintText: "Enter your first name",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  cursorColor: Color(0xFF6F35A5),
                  decoration: InputDecoration(
                    hintText: "Enter your Second name",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      RadioListTile(
                        title: Text("Male"),
                        value: "male",
                        groupValue: gender,
                        onChanged: (value) {
                          // setState(() {
                          //     gender = value.toString();
                          // });
                        },
                      ),
                      RadioListTile(
                        title: Text("Female"),
                        value: "female",
                        groupValue: gender,
                        onChanged: (value) {
                          // setState(() {
                          //     gender = value.toString();
                          // });
                        },
                      ),
                      RadioListTile(
                        title: Text("Other"),
                        value: "other",
                        groupValue: gender,
                        onChanged: (value) {
                          // setState(() {
                          //     gender = value.toString();
                          // });
                        },
                      )
                    ],
                  )),
              const SizedBox(height: 16.0),
              Hero(
                tag: "signUp_btn",
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "SignUp".toUpperCase(),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ]));
  }
}
