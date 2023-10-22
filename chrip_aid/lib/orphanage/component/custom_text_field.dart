import 'package:flutter/material.dart';
import 'package:chrip_aid/common/styles/styles.dart';

class CustomTextField extends StatelessWidget {
  final IconData? iconData;
  final String text;
  final double? textSize;
  final Color? color;
  final double verticalMargin;
  final double horizontalMargin;

  const CustomTextField({
    Key? key,
    this.iconData,
    required this.text,
    this.textSize = kTextSmallSize,
    this.color = Colors.black,
    this.verticalMargin = kPaddingMiniMiniSize,
    this.horizontalMargin = kPaddingMiniMiniSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: verticalMargin, horizontal: horizontalMargin),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey),
      //   borderRadius: BorderRadius.circular(8.0),
      // ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (iconData != null)
            Icon(
              iconData,
              size: kTextXSmallSize,
              color: Colors.black,
            ),
          if (iconData != null) const SizedBox(width: kPaddingSmallSize),
          Expanded(
            child: Text(
              text,
              style: kTextPointStyleSmall.copyWith(
                color: color,
                fontSize: textSize,
              ),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}