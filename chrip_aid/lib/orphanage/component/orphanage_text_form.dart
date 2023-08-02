import 'package:chrip_aid/common/styles/styles.dart';
import 'package:flutter/material.dart';

class OrphanageTextForm extends StatelessWidget {
  final String title;
  final IconData iconData;
  final TextEditingController? controller;
  final EdgeInsetsGeometry margin;

  const OrphanageTextForm({
    super.key,
    required this.title,
    required this.iconData,
    this.controller,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                size: kTextXSmallSize,
                color: CustomColor.mainColor,
              ),
              const SizedBox(width: 5.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: kTextXSmallSize,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.mainColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: kPaddingSmallSize,
          ),
          TextFormField(
            controller: controller,
            style: kTextMainStyleSmall,
            cursorColor: CustomColor.mainColor,
            maxLines: null,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(
                left: kPaddingMiddleSize,
                bottom: kPaddingMiddleSize,
              ),
              hintStyle: kTextMainStyleMiddle,
              filled: true,
              fillColor: CustomColor.backGroundSubColor,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
