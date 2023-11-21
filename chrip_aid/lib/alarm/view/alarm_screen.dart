import 'package:chrip_aid/alarm/component/alarm_item.dart';
import 'package:chrip_aid/alarm/viewmodel/alarm_viewmodel.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
import 'package:chrip_aid/root_tab/view/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlarmScreen extends TabScreen {
  @override
  Color get mainColor => CustomColor.subColor;

  const AlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(alarmViewmodelProvider)..getAlarms();
    return DefaultLayout(
      title: "Alarm",
      appbarColor: mainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      child: ValueStateListener(
        state: viewModel.alarmState,
        successBuilder: (_, state) => ListView.builder(
          itemCount: state.value!.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.all(
              kPaddingSmallSize,
            ).copyWith(bottom: 0),
            child: AlarmItem(
              state.value![i],
              onTap: () => viewModel.navigateToScreen(
                context,
                state.value![i].type,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
