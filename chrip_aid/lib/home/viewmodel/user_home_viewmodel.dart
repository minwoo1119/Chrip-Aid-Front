import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/common/const/tabs.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_service.dart';
import 'package:chrip_aid/orphanage/view/orphanage_map_screen.dart';
import 'package:chrip_aid/post/model/service/orphanage_post_service.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/reservation/model/service/reservation_service.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final userHomeViewModelProvider =
    ChangeNotifierProvider((ref) => UserHomeViewModel(ref));

class UserHomeViewModel extends ChangeNotifier {
  Ref ref;

  late AuthService _authService;
  late MemberInfoService _memberInfoService;

  AuthState get authState => _authService.authState;

  MemberInfoState get memberState => _memberInfoService.memberInfoState;

  UserHomeViewModel(this.ref) {
    _authService = ref.read(authServiceProvider);
    authState.addListener(() {
      if (authState.isSuccess) {
        _memberInfoService.getMemberInfo();
      }
    });

    _memberInfoService = ref.read(memberInfoServiceProvider);

    rootTabController.addListener(() {
      if (rootTabController.index == 2 && !memberState.isSuccess) {
        _memberInfoService.getMemberInfo();
      }
    });
  }

  Future navigateToSearchScreen(BuildContext context) async {
    if (!memberState.isSuccess) {
      await _memberInfoService.getMemberInfo();
    }
    ref
        .read(orphanageServiceProvider.notifier)
        .getOrphanageList()
        .then((value) => context.pushNamed(OrphanageMapScreen.routeName));
  }

  Future navigateToReservationScreen(BuildContext context) async {
    ref
        .read(reservationServiceProvider.notifier)
        .getOrphanageReservation()
        .then((value) => context.pushNamed(ReservationScreen.routeName));
  }

  Future navigateToPostScreen(BuildContext context) async {
    ref.read(orphanagePostServiceProvider.notifier).getOrphanagePosts();
    if (context.mounted) context.pushNamed(PostScreen.routeName);
  }
}
