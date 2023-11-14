import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/common/const/tabs.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/management/model/service/orphanage_management_service.dart';
import 'package:chrip_aid/management/view/orphanage_management_screen.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/viewmodel/orphanage_member_info_viewmodel.dart';
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

  late AuthService _service;
  AuthState get authState => _service.authState;

  OrphanageHomeViewModel(this.ref) {
    _service = ref.read(authServiceProvider);
    authState.addListener(() {
      if (authState.isSuccess) {
        ref.read(memberInfoServiceProvider.notifier).getMemberInfo().then(
                (value) => ref
                .read(orphanageManagementServiceProvider.notifier)
                .getOrphanageInfo());
      }
    });

    rootTabController.addListener(() async {
      if (rootTabController.index == 2 &&
              (ref.read(memberInfoServiceProvider) is! SuccessState) ||
          (ref.read(orphanageManagementServiceProvider) is! SuccessState)) {
        ref.read(memberInfoServiceProvider.notifier).getMemberInfo().then(
              (value) => ref
                  .read(orphanageManagementServiceProvider.notifier)
                  .getOrphanageInfo(),
            );
      }
    });
  }

  Future navigateToOrphanageScreen(BuildContext context) async {
    if (ref.read(memberInfoServiceProvider) is! SuccessState) {
      await ref.read(memberInfoServiceProvider.notifier).getMemberInfo();
    }
    if(ref.read(orphanageManagementServiceProvider) is! SuccessState) {
      await ref.read(orphanageManagementServiceProvider.notifier).getOrphanageInfo();
    }
    context.pushNamed(OrphanageManagementScreen.routeName);
  }

  Future navigateToReservationScreen(BuildContext context) async {
    await ref
        .read(orphanageReservationServiceProvider.notifier)
        .getOrphanageVisitReservation();
    context.pushNamed(ReservationScreen.routeName);
  }

  Future navigateToPostScreen(BuildContext context) async {
    await ref.read(orphanagePostServiceProvider.notifier).getOrphanagePosts();
    context.pushNamed(PostScreen.routeName);
  }
}
