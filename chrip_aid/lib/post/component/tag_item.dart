import 'package:chrip_aid/common/styles/styles.dart';
import 'package:flutter/material.dart';

class TagItem extends StatelessWidget {
  final String tag;
  final bool isChecked;

  const TagItem(
    this.tag, {
    Key? key,
    this.isChecked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor:
          isChecked ? CustomColor.mainColor : CustomColor.backgroundMainColor,
      side: BorderSide(
        color: isChecked ? CustomColor.backgroundMainColor : Colors.black,
      ),
      label: Text(
        tag,
        style: kTextContentStyleSmall.copyWith(
          color: isChecked
              ? CustomColor.textReverseColor
              : CustomColor.textSubColor,
        ),
      ),
    );
  }
}
