import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/orphanage/component/custom_field_padding.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';
import 'package:flutter/material.dart';

class CustomBasketProductBox3 extends StatelessWidget {
  final ProductEntity entity;

  const CustomBasketProductBox3({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(entity.image, fit: BoxFit.fitWidth),
        ),
        const SizedBox(height: kPaddingSmallSize),
        CustomFieldPadding(
          text: entity.title,
          textSize: kTextSmallSize,
        ),
        const SizedBox(height: kPaddingSmallSize),
        Row(
          children: [
            const CustomFieldPadding(
              text: "₩",
              textSize: kTextSmallSize,
            ),
            CustomFieldPadding(
              text: "${entity.price}",
              textSize: kTextMediumSize,
            ),
            Expanded(child: Container()),

          ],
        ),
      ],
    );
  }
}
