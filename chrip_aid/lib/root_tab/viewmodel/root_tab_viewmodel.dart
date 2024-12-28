import 'package:chrip_aid/alarm/view/alarm_screen.dart';
import 'package:chrip_aid/auth/model/state/authority_state.dart';
import 'package:chrip_aid/common/const/tabs.dart';
import 'package:chrip_aid/home/view/orphanage_home_screen.dart';
import 'package:chrip_aid/home/view/admin_home_screen.dart';
import 'package:chrip_aid/home/view/user_home_screen.dart';
import 'package:chrip_aid/member/view/orphanage_member_info_screen.dart';
import 'package:chrip_aid/member/view/user_info_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_map_screen.dart';
import 'package:chrip_aid/post/view/user_post_screen.dart';
import 'package:chrip_aid/reservation/view/user_reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rootTabViewModelProvider = Provider((ref) => RootTabViewModel());

class RootTabViewModel {
  final authorityState = AuthorityState();
  late TabController rootTabController;

  List<TabInfo> get tabs {
    switch (authorityState.value!) {
      case AuthorityType.user:
        return const [
          TabInfo(UserHomeScreen(), icon: Icons.home, label: '예약 설정'),
          TabInfo(OrphanageMapScreen(), icon: Icons.map, label: '보육원 검색'),
          TabInfo(UserPostScreen(), icon: Icons.volunteer_activism, label: '인증글 확인'),
          TabInfo(UserReservationScreen(), icon: Icons.history, label: '신청 내역'),
          TabInfo(UserInfoScreen(), icon: Icons.person, label: '마이페이지'),
        ];
      case AuthorityType.orphanage:
        return const [
          TabInfo(AlarmScreen(), icon: Icons.notifications, label: '예약 현황 조회'),
          TabInfo(OrphanageHomeScreen(), icon: Icons.home, label: '예약 설정'),
          TabInfo(OrphanageMemberInfoScreen(), icon: Icons.person, label: '마이페이지'),
        ];
      case AuthorityType.admin:
        return const [
          TabInfo(AlarmScreen(), icon: Icons.notifications, label: '예약 현황 조회'),
          TabInfo(AdminHomeScreen(), icon: Icons.home, label: '예약 설정'),
          TabInfo(UserInfoScreen(), icon: Icons.person, label: '마이페이지'),
        ];
    }
  }

  void getInfo(TickerProvider vsync) => rootTabController = TabController(
    length: tabs.length,
    animationDuration: Duration.zero,
    vsync: vsync,
    initialIndex: 0,
  );
}
