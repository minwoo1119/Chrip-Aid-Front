import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomChatsList extends ConsumerWidget {
  final String chat_room_id;
  final String target_id;
  final String last_chat;

  const CustomChatsList({
    super.key,
    required this.chat_room_id,
    required this.target_id,
    required this.last_chat,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        _navigateToDetailPage(context, chat_room_id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4), // 그림자 위치
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/image/logo.png",
                height: 60.0,
                width: 60.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '보육원이름',  // 실제 데이터로 변경 가능
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    last_chat,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetailPage(BuildContext context, String chat_room_id) {
    context.push(
      '/chatting/$chat_room_id',
    );
  }
}
