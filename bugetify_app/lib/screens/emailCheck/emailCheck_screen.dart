import 'package:flutter/material.dart';
import '../../components/background.dart';
import 'components/emailCheck_top_image.dart';
import 'components/emailCheck_form.dart';

class emailCheckScreen extends StatelessWidget {
  const emailCheckScreen({Key? key}) : super(key: key);

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
            child: (MobileemailCheckScreen()),
          ),
        ));
  }
}

class MobileemailCheckScreen extends StatelessWidget {
  const MobileemailCheckScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const emailCheckScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: emailCheckForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
