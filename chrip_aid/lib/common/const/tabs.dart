import 'package:chrip_aid/common/view/tab_screen.dart';
import 'package:chrip_aid/home/view/home_screen.dart';
import 'package:chrip_aid/member/view/user_info_screen.dart';
import 'package:flutter/material.dart';

class TabInfo {
  final IconData icon;
  final String label;
  final TabScreen tab;

  const TabInfo(this.tab, {required this.icon, required this.label});
}

// ignore: constant_identifier_names
const TABS = [
  TabInfo(HomeScreen(), icon: Icons.notifications, label: '예약 현황 조회'),
  TabInfo(HomeScreen(), icon: Icons.home, label: '예약 설정'),
  TabInfo(UserInfoScreen(), icon: Icons.person, label: "사용자 설정"),
];