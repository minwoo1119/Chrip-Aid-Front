import 'package:flutter/material.dart';

class CustomPostList extends StatelessWidget {
  final String title;
  final String content;
  final String writtenAt;
  final String nickname;
  final int id;
  final String postType;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const CustomPostList({
    super.key,
    required this.title,
    required this.content,
    required this.writtenAt,
    required this.nickname,
    required this.id,
    required this.postType,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.green,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    writtenAt,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Column(
              children: [
                Text(
                  nickname,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red.withOpacity(0.7), // 연한 빨간색
                      onPressed: () => _handleDeletePost(context, ref),
                      tooltip: '삭제',
                    ),
                  ],
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: onDelete,
                  child: Row(
                    children: const [
                      Icon(Icons.delete),
                      Text("삭제"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
