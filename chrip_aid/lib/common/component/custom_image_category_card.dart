import 'package:flutter/material.dart';

class CustomImageCategoryCard extends StatelessWidget {
  final String title; // 제목
  final String subtitle; // 부제목
  final String imagePath; // 이미지 경로
  final Color textColor; // 텍스트 색상
  final Color backgroundColor; // 배경 색상
  final void Function()? onPressed; // 클릭 이벤트

  const CustomImageCategoryCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.orange, // 기본 배경색
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: textColor.withOpacity(0.8),
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Image.asset(
              imagePath,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
