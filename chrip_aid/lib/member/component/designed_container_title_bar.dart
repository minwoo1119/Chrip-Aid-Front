import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/orphanage/component/custom_text_field.dart';
import 'package:flutter/material.dart';

class DesignedContainerTitleBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const DesignedContainerTitleBar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leading ?? Container(),
        Expanded(
          child: CustomTextField(
            text: title,
            textSize: kTextMiddleSize,
          ),
        ),
        ...actions ?? [],
      ],
    );
  }
}
