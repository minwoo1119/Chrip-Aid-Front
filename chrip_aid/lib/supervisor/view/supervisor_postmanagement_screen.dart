import 'package:chrip_aid/common/component/custom_post_list.dart';
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

class SupervisorPostManagementScreen extends ConsumerWidget{
  static String get routeName => 'postmanagement';
  static const List<Map<String, dynamic>> dummyData = [
    {
      'title': '초코파이',
      'content': '초코파이 주세요',
      'writtenAt': '2024-01-28',
      'nickname': 'babayLion',
    },
    {
      'title': '우유',
      'content': '서울우유로 주세요',
      'writtenAt': '2024-04-24',
      'nickname': 'babayLion',
    },
    {
      'title': '동그랑땡',
      'content': '명절 느낌 내게해줘요',
      'writtenAt': '2024-09-18',
      'nickname': 'babayLion',
    },
    {
      'title': '마가렛트',
      'content': '마가렛트 3개',
      'writtenAt': '2024-03-11',
      'nickname': 'babayLion',
    },
  ];

  const SupervisorPostManagementScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(supervisorAccountManagementViewModelProvider)..getInfo();

    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '게시글 관리',
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
                  options: [
                  '방문 예약',
                    '물품 요청',
                    '기부 감사',
                ],
                ),
                SizedBox(height: 6.0),
                Column(
                  children: dummyData.map((user) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: CustomPostList(
                        title: user['title'],
                        content: user['content'],
                        writtenAt: user['writtenAt'],
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
      '/supervisor/postmanagement/postdetail',
      extra: userData,
    );
  }
}