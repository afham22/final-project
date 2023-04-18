import 'package:flutter/material.dart';
import '../../components/background.dart';
import 'components/signUp_form.dart';

class signUpScreen extends StatelessWidget {
  const signUpScreen({Key? key}) : super(key: key);

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
        body: const Background(
          child: SingleChildScrollView(
            child: MobilesignUpScreen(),
          ),
        ));
  }
}

class MobilesignUpScreen extends StatelessWidget {
  const MobilesignUpScreen({
    Key? key,
  }) : super(key: key);

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
              child: signUpForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
