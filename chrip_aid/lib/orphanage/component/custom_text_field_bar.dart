import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFieldBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onTap;
  final Function(String)? onChanged;

  const CustomTextFieldBar({
    Key? key,
    required this.controller,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      decoration: BoxDecoration(
        color: CustomColor.backGroundSubColor,
        borderRadius: BorderRadius.circular(kBorderRadiusSize),
        border: Border.all(color: CustomColor.mainColor, width: 3),
      ),
      padding: const EdgeInsets.symmetric(horizontal: kPaddingSmallSize),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: kPaddingMiniSize),
                child: TextFormField(
                  controller: controller,
                  style: kTextMainStyleMiddle,
                  cursorColor: CustomColor.mainColor,
                  onTap: onTap,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    fillColor: CustomColor.backGroundSubColor,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onChanged: onChanged,
                ),
              ),
            ),
            const Icon(
              Icons.search,
              size: kIconMainSize,
              color: CustomColor.mainColor,
            ),
          ],
        ),
      ),
    );
  }
}
