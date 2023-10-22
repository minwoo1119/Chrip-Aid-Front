import 'package:flutter/material.dart';
import 'package:chrip_aid/common/styles/styles.dart';

class ExpandableProductNames extends StatefulWidget {
  final List<String> productNames;

  const ExpandableProductNames({
    Key? key,
    required this.productNames,
  }) : super(key: key);

  @override
  _ExpandableProductNamesState createState() => _ExpandableProductNamesState();
}

class _ExpandableProductNamesState extends State<ExpandableProductNames> {
  bool showAllProductNames = false;

  @override
  Widget build(BuildContext context) {
    final displayedProductNames = showAllProductNames
        ? widget.productNames
        : widget.productNames.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          children: displayedProductNames.map((productName) {
            return Text(
              "#$productName",
              style: kTextPointStyleSmall.copyWith(
                  fontSize: kTextMiniSize, color: CustomColor.contentSubColor),
              // fontSize: kTextMiniSize, color: const Color(0xFF1a05ac)),
            );
          }).toList(),
        ),
        SizedBox(
          height: 5,
        ),
        if (widget.productNames.length > 3)
          InkWell(
            onTap: () {
              setState(() {
                showAllProductNames = !showAllProductNames;
              });
            },
            child: Row(
              children: [
                Text(
                  showAllProductNames ? '간략히 보기' : '..더 보기',
                  style: kTextPointStyleSmall.copyWith(
                    fontSize: kTextMiniSize,
                    color: CustomColor.contentSubColor,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
