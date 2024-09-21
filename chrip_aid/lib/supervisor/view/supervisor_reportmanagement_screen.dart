import 'package:chrip_aid/orphanage/component/custom_text_field.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/management/viewmodel/orphanage_management_viewmodel.dart';
import 'package:chrip_aid/supervisor/viewmodel/supervisor_accountmanagement_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/component/custom_toggle_button.dart';
import '../../common/styles/colors.dart';
import '../../common/styles/sizes.dart';
import '../../common/styles/text_styles.dart';
import '../../common/value_state/component/value_state_listener.dart';

class SupervisorReportmanagementScreen extends ConsumerWidget{
  static String get routeName => 'reportmanagement';

  const SupervisorReportmanagementScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(supervisorAccountManagementViewModelProvider)..getInfo();

    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '계정 관리',
      titleColor: Colors.white,
      appBarBackgroundColor: CustomColor.buttonMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      leadingColor: CustomColor.textReverseColor,
      actions: [],
      child: ValueStateListener(
        state: viewModel.orphanageState,
        defaultBuilder: (_, state) => SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10.0),
                CustomToggleButton(
                  firstOption: '사용자',
                  secondOption: '보육원',
                ),
                SizedBox(height: 6.0),

              ],
            ),
          ),
        ),
        successBuilder: (_, state) => SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Text('User'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kPaddingMiddleSize,
                      vertical: kPaddingMiniSize,
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          text: 'User1',
                          textSize: kTextMediumSize,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 5.0,
                color: CustomColor.disabledColor.withOpacity(0.5),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: kPaddingMiddleSize,
                  right: kPaddingMiddleSize,
                  top: kPaddingMiniSize,
                  bottom: kPaddingSmallSize,
                ),
                child: Column(
                  children: [
                    const CustomTextField(
                      iconData: Icons.description,
                      text: "소개글",
                    ),
                    Text(
                      '소개글 내용',
                      style: kTextContentStyleSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}