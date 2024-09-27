import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/styles/colors.dart';
import '../../common/styles/sizes.dart';
import '../../orphanage/layout/detail_page_layout.dart';

class ChattingMessageScreen extends ConsumerWidget {
  static String get routeName => 'chatting';
  final String chatRoomId;

  const ChattingMessageScreen({
    super.key,
    required this.chatRoomId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '채팅',
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
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                final chatMessage = dummyData[index];
                return _buildChatBubble(
                  chatMessage['isSentByMe'] as bool,
                  chatMessage['message'] as String,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10.0),
              itemCount: dummyData.length,
            ),
          ),
          _BottomInputField(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(bool isSentByMe, String message) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        decoration: BoxDecoration(
          color: isSentByMe ? CustomColor.itemMainColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSentByMe ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}


final List<Map<String, dynamic>> dummyData = [
  {
    'isSentByMe': true,
    'message': '안녕하세요! 오늘 일정은 어떻게 되세요?',
  },
  {
    'isSentByMe': false,
    'message': '안녕하세요! 오늘 오후에는 회의가 있어요.',
  },
  {
    'isSentByMe': true,
    'message': '회의 준비는 잘 되었나요?',
  },
  {
    'isSentByMe': false,
    'message': '네, 준비 다 했어요.',
  },
  {
    'isSentByMe': true,
    'message': '좋아요. 그럼 회의 끝나고 연락드릴게요!',
  },
  {
    'isSentByMe': false,
    'message': '네, 알겠습니다.',
  },
];

class _BottomInputField extends StatefulWidget {
  @override
  State<_BottomInputField> createState() => _BottomInputFieldState();
}

class _BottomInputFieldState extends State<_BottomInputField> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        dummyData.add({
          'isSentByMe': true,
          'message': _controller.text,
        });
      });
      _controller.clear(); // 메시지 전송 후 입력 필드 초기화
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: '메시지를 입력하세요...',
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blueAccent),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
