import 'package:flutter/material.dart';
import 'package:chrip_aid/common/styles/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;

  final IconData? prefixIcon;

  final TextInputType keyboardType;

  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.keyboardType,
    required this.validator,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.backGroundSubColor,
        borderRadius: BorderRadius.circular(kBorderRadiusSize),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kPaddingSmallSize,
              vertical: kPaddingMiniSize,
            ).copyWith(bottom: kPaddingMiniSize),
            child: Row(
              children: [
                Icon(
                  prefixIcon,
                  size: kIconMiniSize,
                  color: CustomColor.mainColor,
                ),
                const SizedBox(width: kPaddingMiniSize),
                Text(
                  labelText ?? "",
                  style: kTextMainStyleMini,
                ),
              ],
            ),
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            cursorColor: CustomColor.mainColor,
            keyboardType: keyboardType,
            obscureText: keyboardType == TextInputType.visiblePassword,
            style: kTextMainStyleMiddle,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.only(
                left: kPaddingSmallSize,
                bottom: kPaddingSmallSize,
              ),
              hintText: hintText,
              hintStyle: kTextMainStyleMiddle.copyWith(
                color: CustomColor.mainColor.withOpacity(0.5),
              ),
              filled: true,
              fillColor: CustomColor.backGroundSubColor,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(kBorderRadiusSize),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
