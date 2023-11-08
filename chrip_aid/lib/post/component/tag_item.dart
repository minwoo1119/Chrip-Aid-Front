import 'package:chrip_aid/common/styles/styles.dart';
import 'package:flutter/material.dart';

class TagItem extends StatefulWidget {
  final String tag;
  final bool isChecked;
  final void Function(bool)? onTap;

  const TagItem(
    this.tag, {
    Key? key,
    this.isChecked = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<TagItem> createState() => _TagItemState();
}

class _TagItemState extends State<TagItem> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: widget.onTap != null
          ? () {
              setState(() {
                isChecked = !isChecked;
              });
              widget.onTap!(isChecked);
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(kPaddingSmallSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: isChecked
                ? CustomColor.mainColor.withOpacity(0.5)
                : Colors.grey.withOpacity(0.5),
          ),
          color: isChecked
              ? CustomColor.mainColor
              : CustomColor.backgroundMainColor,
        ),
        child: Text(
          "# ${widget.tag}",
          style: kTextContentStyleSmall.copyWith(
            color: isChecked
                ? CustomColor.textReverseColor
                : CustomColor.textSubColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
