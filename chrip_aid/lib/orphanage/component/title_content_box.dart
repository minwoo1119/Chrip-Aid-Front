import 'package:flutter/material.dart';

import '../../common/styles/styles.dart';

class TitleContentBox extends StatelessWidget {
  final String reason;

  const TitleContentBox({super.key, required this.reason});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(kBorderRadiusMiniSize),
                        // border: Border.all(
                        //   color: CustomColor.textSubColor,
                        //   width: 1.0,
                        // ),
                      ),
                      // padding: const EdgeInsets.symmetric(
                      //     vertical: kPaddingMiniSize,
                      //     horizontal: kPaddingSmallSize),
                      child: Text(reason,
                          style: kTextContentStyleSmall, softWrap: true),
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
