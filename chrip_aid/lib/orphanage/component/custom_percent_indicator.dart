import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/orphanage/component/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CustomPercentIndicator extends StatelessWidget {
  final double progress;

  const CustomPercentIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2.0),
          child: LinearPercentIndicator(
            lineHeight: 17.0,
            percent: progress,
            backgroundColor: CustomColor.subColor,
            progressColor: CustomColor.mainColor,
            barRadius: const Radius.circular(10.0),
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
          ),
        ),
        CustomTextField(
          text: "진행도: ${progress * 100}%",
          textSize: 12.0,
          color: Colors.white,
          horizontalMargin: 5.0,
        )
      ],
    );
  }
}
