import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/common/const/tabs.dart';
import 'package:chrip_aid/management/model/service/orphanage_management_service.dart';
import 'package:chrip_aid/management/view/orphanage_management_screen.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:chrip_aid/post/model/service/orphanage_post_service.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/reservation/model/service/orphanage_reservation_service.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageHomeViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageHomeViewModel(ref));

class OrphanageHomeViewModel extends ChangeNotifier {
  Ref ref;

  late AuthService _authService;
  late MemberInfoService _memberInfoService;
  late OrphanageManagementService _orphanageManagementService;

  AuthState get authState => _authService.authState;

  MemberInfoState get memberState => _memberInfoService.memberInfoState;

  OrphanageDetailState get orphanageDetailState =>
      _orphanageManagementService.orphanageDetailState;

  OrphanageHomeViewModel(this.ref) {
    _authService = ref.read(authServiceProvider);
    _memberInfoService = ref.read(memberInfoServiceProvider);
    _orphanageManagementService = ref.read(orphanageManagementServiceProvider);

    authState.addListener(() {
      if (authState.isSuccess) _memberInfoService.getMemberInfo();
    });

    memberState.addListener(() {
      if (memberState.isSuccess) _orphanageManagementService.getOrphanageInfo();
    });

    rootTabController.addListener(() async {
      if (rootTabController.index == 2) {
        if(!memberState.isSuccess) await _memberInfoService.getMemberInfo();
        if(!orphanageDetailState.isSuccess) _orphanageManagementService.getOrphanageInfo();
      }
    });
  }

  Future navigateToOrphanageScreen(BuildContext context) async {
    if (!memberState.isSuccess) await _memberInfoService.getMemberInfo();
    if (!orphanageDetailState.isSuccess) await _orphanageManagementService.getOrphanageInfo();
    if (context.mounted) context.pushNamed(OrphanageManagementScreen.routeName);
  }

  Future navigateToReservationScreen(BuildContext context) async {
    await ref
        .read(orphanageReservationServiceProvider)
        .getOrphanageVisitReservation();
    if (context.mounted) context.pushNamed(ReservationScreen.routeName);
  }

  Future navigateToPostScreen(BuildContext context) async {
    await ref.read(orphanagePostServiceProvider).getOrphanagePosts();
    if (context.mounted) context.pushNamed(PostScreen.routeName);
  }
}
