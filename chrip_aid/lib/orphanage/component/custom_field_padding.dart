import 'package:flutter/material.dart';
import 'package:chrip_aid/common/styles/styles.dart';

class CustomFieldPadding extends StatelessWidget {
  final String text;
  final double? textSize;
  final Color? color;
  final double verticalMargin;
  final double horizontalMargin;

  const CustomFieldPadding(
      {Key? key,
      required this.text,
      this.textSize = kTextSmallerSize,
      this.color = Colors.black,
      this.verticalMargin = 0.0,
      this.horizontalMargin = 5.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: verticalMargin, horizontal: horizontalMargin),
      child: Text(
        text,
        style: kTextPointStyleSmall.copyWith(color: color, fontSize: textSize),
      ),
    );
  }
}
