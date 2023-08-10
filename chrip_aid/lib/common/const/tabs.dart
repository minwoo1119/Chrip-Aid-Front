import 'package:flutter/material.dart';

class TabInfo {
  final IconData icon;
  final String label;

  const TabInfo({required this.icon, required this.label});
}

// ignore: constant_identifier_names
const TABS = [
  TabInfo(icon: Icons.notifications, label: '예약 현황 조회'),
  TabInfo(icon: Icons.home, label: '예약 설정'),
  TabInfo(icon: Icons.person, label: "사용자 설정"),
];