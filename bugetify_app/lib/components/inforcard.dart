import 'package:bugetify_app/components/primarytext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InfoCard extends StatelessWidget {
  final String icon;
  final String label;
  final String amount;

  InfoCard({required this.icon, required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final blockSizeVertical = screenWidth / 100;

    return Container(
      constraints: BoxConstraints(minWidth: screenWidth / 2 - 40),
      padding: EdgeInsets.symmetric(
        vertical: blockSizeVertical * 2,
        horizontal: blockSizeVertical * 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            icon,
            width: blockSizeVertical * 8,
          ),
          SizedBox(height: blockSizeVertical * 2),
          PrimaryText(
            text: label,
            color: Color(0xffa6a6a6),
            size: blockSizeVertical * 4,
          ),
          SizedBox(height: blockSizeVertical * 2),
          PrimaryText(
            text: amount,
            size: blockSizeVertical * 4.5,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
