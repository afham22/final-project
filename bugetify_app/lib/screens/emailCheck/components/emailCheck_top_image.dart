import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class emailCheckScreenTopImage extends StatelessWidget {
  const emailCheckScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Verify Email".toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset("assets/icons/signup.svg"),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
