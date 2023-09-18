import 'package:chrip_aid/common/styles/colors.dart';
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadiusSize),
          color: CustomColor.backGroundSubColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ]
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(kBorderRadiusSize),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 215,
                child: Image.asset(
                  entity.photo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kLayoutGutter,
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
