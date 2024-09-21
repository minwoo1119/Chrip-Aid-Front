import 'package:chrip_aid/common/component/custom_detail_info.dart';
import 'package:chrip_aid/common/component/custom_toggle_button.dart';
import 'package:chrip_aid/common/component/custom_user_list.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/styles/text_styles.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
import 'package:chrip_aid/orphanage/component/custom_product_box_2.dart';
import 'package:chrip_aid/orphanage/component/custom_text_field.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/management/viewmodel/orphanage_management_viewmodel.dart';
import 'package:chrip_aid/supervisor/viewmodel/supervisor_accountmanagement_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SupervisorAccountmanagementScreen extends ConsumerWidget {
  static String get routeName => "accountmanagement";
  static const List<Map<String, dynamic>> dummyData = [
    {
      'name': 'minwoo',
      'email': 'minu@example.com',
      'phoneNumber': '010-0000-0001',
      'nickname': 'babayLion',
    },
    {
      'name': 'juheok',
      'email': 'juh@example.com',
      'phoneNumber': '010-0000-0002',
      'nickname': 'King of Spring',
    },
    {
      'name': 'youngjin',
      'email': 'yong@example.com',
      'phoneNumber': '010-0000-0003',
      'nickname': 'The King',
    },
    {
      'name': 'seongYoon',
      'email': 'IloveIoT@example.com',
      'phoneNumber': '010-0000-0004',
      'nickname': 'EmbeddedKing',
    },
  ];

  const SupervisorAccountmanagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(supervisorAccountManagementViewModelProvider)..getInfo();
    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '계정 관리',
      titleColor: Colors.white,
      appBarBackgroundColor: CustomColor.buttonMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      leadingColor: CustomColor.textReverseColor,
      actions: [
        IconButton(
          onPressed: () => viewModel.navigateToEditOrphanageScreen(context),
          icon: const Icon(Icons.search, size: kIconSmallSize),
          color: CustomColor.textReverseColor,
          splashRadius: kIconSmallSize,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: kPaddingMiddleSize),
      ],
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
                Column(
                  children: dummyData.map((user) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: CustomUserList(
                        name: user['name'],
                        email: user['email'],
                        phoneNumber: user['phoneNumber'],
                        nickname: user['nickname'],
                        onTap: () => _navigateToDetailPage(context, user),
                      ),
                    );
                  }).toList(),
                ),
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

  void _navigateToDetailPage(BuildContext context, Map<String, dynamic> userData) {
    context.push(
      '/supervisor/accountmanagement/detail',
      extra: userData,
    );
  }
}
