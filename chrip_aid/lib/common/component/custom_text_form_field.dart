import 'package:chrip_aid/common/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? headText;
  final String? tailText;

  final IconData? prefixIcon;

  final TextInputType keyboardType;

  final void Function(String?)? onChange;
  final String? Function(String?)? validator;
  final TextEditingController? textController;

  final TextStyle? textStyle;
  final TextStyle decorationStyle;
  final EdgeInsets contentPadding;
  final Color? backgroundColor;
  final Color? fieldColor;
  final int? minLine;

  final BorderRadiusGeometry borderRadius;

  final bool? enabled;

  final List<FilteringTextInputFormatter>? inputFormatters;

  late final InputBorder inputBorder;

  CustomTextFormField({
    Key? key,
    this.labelText,
    this.hintText,
    this.headText,
    this.tailText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.onChange,
    this.validator,
    this.textController,
    this.textStyle,
    this.decorationStyle = kTextMainStyleSmall,
    this.inputFormatters,
    this.enabled,
    InputBorder? inputBorder,
    this.borderRadius =
        const BorderRadius.all(Radius.circular(kBorderRadiusSize)),
    this.backgroundColor,
    this.fieldColor,
    this.minLine,
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
        color: backgroundColor ?? CustomColor.backgroundMainColor,
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.all(kPaddingSmallSize),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (prefixIcon != null) ...[
                Icon(
                  prefixIcon,
                  size: kIconSmallSize,
                  color: decorationStyle.color,
                ),
                const SizedBox(width: kPaddingSmallSize),
              ],
              if (labelText != null)
                Text(
                  labelText!,
                  style: decorationStyle,
                ),
            ],
          ),
          const SizedBox(height: kPaddingSmallSize),
          Row(
            children: [
              if (headText != null) ...[
                Text(
                  headText!,
                  style: decorationStyle,
                ),
                const SizedBox(width: kPaddingSmallSize),
              ],
              Expanded(
                child: TextFormField(
                  minLines: minLine,
                  maxLines: minLine ?? 1,
                  enabled: enabled,
                  controller: textController,
                  validator: validator,
                  cursorColor: textStyle?.color,
                  keyboardType: keyboardType,
                  obscureText: keyboardType == TextInputType.visiblePassword,
                  style: textStyle ?? kTextMainStyleMiddle,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: contentPadding,
                    hintText: hintText,
                    border: inputBorder,
                    disabledBorder: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                    hintStyle: textStyle?.copyWith(
                          color: CustomColor.textMainColor.withOpacity(0.5),
                        ) ??
                        kTextMainStyleMiddle.copyWith(
                          color: CustomColor.textMainColor.withOpacity(0.5),
                        ),
                    filled: true,
                    fillColor: fieldColor ?? CustomColor.backgroundMainColor,
                  ),
                  onChanged: onChange,
                ),
              ),
              if (tailText != null) ...[
                const SizedBox(width: kPaddingSmallSize),
                Text(
                  tailText!,
                  style: decorationStyle,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
