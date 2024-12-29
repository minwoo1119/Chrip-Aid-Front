import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 80.0, // AppBar 높이
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // 좌우 여백
      decoration: BoxDecoration(
        color: Colors.white, // 배경색을 BoxDecoration으로 이동
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!, // 하단 경계선 색상
            width: 1.0, // 하단 경계선 두께
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 왼쪽과 오른쪽 정렬
        crossAxisAlignment: CrossAxisAlignment.center, // 세로 가운데 정렬
        children: [
          // 제목과 소제목
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Chirp Aid",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                "보육원과 마음을 잇는 플랫폼",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          // 알림 아이콘
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 28.0,
            ),
            onPressed: () {
              context.push('/alarm'); // 실제 라우트에 맞게 수정 필요
            },
          ),
        ],
      ),
    );
  }
}
