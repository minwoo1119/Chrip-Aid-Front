import 'package:flutter/material.dart';

import '../../common/styles/styles.dart';

class ReasonBox extends StatelessWidget {
  final String reason;
  final String title;

  const ReasonBox({super.key, required this.reason, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: kTextDetailSubContentStyleSmall,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(kBorderRadiusMiniSize),
                        // border: Border.all(
                        //   color: CustomColor.disabledColor,
                        //   width: 1.0,
                        // ),
                      ),
                      // padding: const EdgeInsets.symmetric(
                      //     vertical: kPaddingMiniSize,
                      //     horizontal: kPaddingSmallSize),
                      child: Text(reason,
                          style: kTextDetailContentStyleSmall, softWrap: true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
