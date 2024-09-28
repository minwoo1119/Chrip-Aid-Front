import 'package:chrip_aid/common/component/custom_chats_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/styles/colors.dart';
import '../../common/styles/sizes.dart';
import '../../orphanage/layout/detail_page_layout.dart';

class ChattingScreen extends ConsumerWidget {
  static String get routeName => 'chatting';

  const ChattingScreen({super.key});
  Color get mainColor => CustomColor.mainColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: 'Chats',
      titleColor: Colors.white,
      appBarBackgroundColor: CustomColor.buttonMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      leadingColor: CustomColor.textReverseColor,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, size: kIconSmallSize),
          color: CustomColor.textReverseColor,
          splashRadius: kIconSmallSize,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: kPaddingMiddleSize),
      ],
      child: Column(
        children: [
          SizedBox(height: 20.0,),
          CustomChatsList(
            chat_room_id: '2jdek290',
            target_id: '안형태 교수님',
            last_chat: '학회를 가기 위한 여정은 잘 되어가니?',
          ),
          CustomChatsList(
            chat_room_id: '3abce320',
            target_id: '정성윤',
            last_chat: '오늘 저녁 뭐 먹을까?',
          ),
          CustomChatsList(
            chat_room_id: '4bde1341',
            target_id: '채주혁',
            last_chat: '내일 회의 몇 시에 시작하지?',
          ),
          CustomChatsList(
            chat_room_id: '5cfr2391',
            target_id: '황용진',
            last_chat: '프로젝트 진행 상황 어때?',
          ),
          CustomChatsList(
            chat_room_id: '6hij3012',
            target_id: '권오빈',
            last_chat: '커피 한 잔 할래?',
          ),
        ],
      ),
    );
  }
}
