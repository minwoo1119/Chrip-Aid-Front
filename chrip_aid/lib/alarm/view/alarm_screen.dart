import 'package:chrip_aid/alarm/component/alarm_item.dart';
import 'package:chrip_aid/alarm/viewmodel/alarm_viewmodel.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/view/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlarmScreen extends TabScreen {
  @override
  Color get mainColor => CustomColor.subColor;

  const AlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(alarmViewmodelProvider);
    return DefaultLayout(
      title: "Alarm",
      appbarColor: mainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      child: ListView.builder(
        itemCount: viewModel.entities.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.all(kPaddingSmallSize).copyWith(bottom: 0),
          child: AlarmItem(
            viewModel.entities[i],
            onTap: () => viewModel.navigateToScreen(
              context,
              viewModel.entities[i].type,
            ),
          ),
        ),
      ),
    );
  }
}
