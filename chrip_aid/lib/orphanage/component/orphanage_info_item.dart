import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/orphanage/component/custom_text_field.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_entity.dart';
import 'package:flutter/material.dart';

class OrphanageInfoItem extends StatelessWidget {
  final OrphanageEntity entity;
  final VoidCallback? onTap;

  const OrphanageInfoItem({
    Key? key,
    required this.entity,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusSize),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(kBorderRadiusSize),
              ),
              child: Image.asset(entity.photo, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: kPaddingMiniSize,
              ),
              child: Column(
                children: [
                  CustomTextField(
                    text: entity.orphanageName,
                    textSize: kTextMediumSize,
                  ),
                  CustomTextField(
                    iconData: Icons.location_on,
                    text: entity.address,
                  ),
                  CustomTextField(
                    iconData: Icons.phone,
                    text: entity.phoneNumber,
                  ),
                  CustomTextField(
                    iconData: Icons.person,
                    text: entity.name,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
