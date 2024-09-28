import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/styles/colors.dart';
import '../../common/styles/sizes.dart';
import '../../orphanage/layout/detail_page_layout.dart';

class ChattingMessageScreen extends ConsumerWidget {
  static String get routeName => 'chatting';
  final String chatRoomId;
  final String targetId;

  const ChattingMessageScreen({
    super.key,
    required this.chatRoomId,
    required this.targetId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '${targetId}',
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
                bool isSentByMe = index % 2 == 0;
                return _buildChatBubble(
                  isSentByMe,
                  '채팅 메시지 $index',
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10.0),
              itemCount: 20, // 메시지 개수 (더미 데이터)
            ),
          ),
          _BottomInputField(), // 채팅 입력 필드
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
          color: isSentByMe ? CustomColor.itemMainColor : Colors.grey[200],
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

class _BottomInputField extends StatefulWidget {
  @override
  State<_BottomInputField> createState() => _BottomInputFieldState();
}

class _BottomInputFieldState extends State<_BottomInputField> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      // 메시지를 전송하는 로직 추가 (예: 서버로 메시지 전송)
      print('Message sent: ${_controller.text}');
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
              onPressed: _sendMessage, // 메시지 전송
            ),
          ],
        ),
      ),
    );
  }
}
