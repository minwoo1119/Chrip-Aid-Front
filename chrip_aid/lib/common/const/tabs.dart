import 'package:chrip_aid/auth/provider/user_type_provider.dart';
import 'package:chrip_aid/common/view/tab_screen.dart';
import 'package:chrip_aid/home/view/orphanage_home_screen.dart';
import 'package:chrip_aid/home/view/user_home_screen.dart';
import 'package:chrip_aid/member/view/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabInfo {
  final IconData icon;
  final String label;
  final TabScreen tab;

  const TabInfo(this.tab, {required this.icon, required this.label});
}

final tabProvider = Provider((ref) {
  final authority = ref.watch(authorityProvider);
  switch (authority) {
    case AuthorityType.user:
      return const [
        // TODO : Create Alarm Screen
        TabInfo(UserHomeScreen(), icon: Icons.notifications, label: '예약 현황 조회'),
        TabInfo(UserHomeScreen(), icon: Icons.home, label: '예약 설정'),
        TabInfo(UserInfoScreen(), icon: Icons.person, label: "사용자 설정"),
      ];
    case AuthorityType.orphanage:
      return const [
        // TODO : Create Alarm Screen
        TabInfo(OrphanageHomeScreen(), icon: Icons.notifications, label: '예약 현황 조회'),
        TabInfo(OrphanageHomeScreen(), icon: Icons.home, label: '예약 설정'),
        // TODO : Create Orphanage Info Screen
        TabInfo(UserInfoScreen(), icon: Icons.person, label: "사용자 설정"),
      ];
  }
});
