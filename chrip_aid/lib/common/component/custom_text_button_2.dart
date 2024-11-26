import 'package:flutter/material.dart';
import 'package:chrip_aid/common/styles/styles.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;

  final String text;
  final Alignment textAlign;

  const CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textAlign = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        alignment: textAlign,
        minimumSize: kTextButtonSize,
        padding: const EdgeInsets.all(kPaddingSmallSize),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: onPressed == null
            ? kTextReverseStyleSmall.copyWith(
                color: CustomColor.textReverseColor.withOpacity(0.5),
              )
            : kTextReverseStyleSmall,
      ),
    );
  }
}
