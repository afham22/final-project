import 'package:flutter/material.dart';
import '../../components/background.dart';
import 'components/signUp_form.dart';

class signUpScreen extends StatelessWidget {
  final TextEditingController checkEmailController;
  signUpScreen(this.checkEmailController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: const BackButton(
            color: Colors.pinkAccent,
          ),
        ),
        body: Background(
          child: SingleChildScrollView(
            child: MobilesignUpScreen(checkEmailController),
          ),
        ));
  }
}

class MobilesignUpScreen extends StatelessWidget {
  final TextEditingController checkEmailController;

  MobilesignUpScreen(this.checkEmailController);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: signUpForm(checkEmailController),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
