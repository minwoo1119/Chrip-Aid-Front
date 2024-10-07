import 'package:flutter/material.dart';

class CustomReportList extends StatelessWidget {
  final String title; // 제목 또는 신고 내용
  final String reporterName; // 신고자 이름
  final String targetName; // 피신고자 이름 또는 대상 이름
  final VoidCallback onTap; // 카드 클릭 시 동작

  const CustomReportList({
    Key? key,
    required this.title,
    required this.reporterName,
    required this.targetName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.green, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8.0),

              // 피신고자 이름 (target)
              Text(
                targetName,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 4.0),

              // 신고자 이름
              Text(
                reporterName,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
