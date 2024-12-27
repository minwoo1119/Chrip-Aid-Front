import 'package:chrip_aid/common/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField_2 extends StatelessWidget {
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final void Function(String?)? onChange;
  final String? Function(String?)? validator;
  final TextEditingController? textController;

  final TextStyle? textStyle;
  final EdgeInsets contentPadding;
  final Color? backgroundColor;
  final Color? fieldColor;
  final int? minLine;
  final int? maxLine;

  final BorderRadiusGeometry borderRadius;
  final bool? enabled;

  final List<FilteringTextInputFormatter>? inputFormatters;

  late final InputBorder inputBorder;

  CustomTextFormField_2({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.onChange,
    this.validator,
    this.textController,
    this.textStyle,
    this.inputFormatters,
    this.enabled,
    InputBorder? inputBorder,
    this.borderRadius =
    const BorderRadius.all(Radius.circular(kBorderRadiusSize)),
    this.backgroundColor,
    this.fieldColor,
    this.minLine,
    this.maxLine,
    this.contentPadding = EdgeInsets.zero,
  }) : super(key: key) {
    this.inputBorder = inputBorder ??
        const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(kBorderRadiusSize),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        border: Border.all( // 테두리 추가
          color: Color(0xFFD8D8D8), // 테두리 색상
          width: 1.0, // 테두리 두께
        ),
      ),
      padding: const EdgeInsets.all(kPaddingSmallSize),
      child: Row(
        children: [
          if (prefixIcon != null) ...[
            Icon(
              prefixIcon,
              size: kIconSmallSize,
              color: Color(0xFF959595), // 아이콘 색상 설정
            ),
            const SizedBox(width: kPaddingSmallSize),
          ],
          Expanded(
            child: TextFormField(
              minLines: minLine,
              maxLines: maxLine ?? minLine ?? 1,
              enabled: enabled,
              controller: textController,
              validator: validator,
              cursorColor: Color(0xFF959595), // 커서 색상 설정
              keyboardType: keyboardType,
              obscureText: keyboardType == TextInputType.visiblePassword,
              style: textStyle ??
                  kTextMainStyleMiddle.copyWith(
                    color: CustomColor.textSubColor,
                  ),
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: contentPadding,
                hintText: hintText,
                hintStyle: textStyle?.copyWith(
                  color: CustomColor.textSubColor.withOpacity(0.5),
                  fontSize: 14.0, // 힌트 텍스트 크기 줄이기
                ) ?? kTextMainStyleMiddle.copyWith(
                  color: CustomColor.textSubColor.withOpacity(0.5),
                  fontSize: 14.0, // 기본 힌트 텍스트 크기 설정
                ),
                border: inputBorder,
                hoverColor: Colors.transparent,
                disabledBorder: inputBorder,
                enabledBorder: inputBorder,
                focusedBorder: inputBorder,
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: onChange,
            ),
          ),
        ],
      ),
    );
  }
}
