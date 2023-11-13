import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/common/const/tabs.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/management/model/service/orphanage_management_service.dart';
import 'package:chrip_aid/management/view/orphanage_management_screen.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageHomeViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageHomeViewModel(ref));

class OrphanageHomeViewModel extends ChangeNotifier {
  Ref ref;

  late AuthState authState;

  OrphanageHomeViewModel(this.ref) {
    authState = ref.read(authServiceProvider);
    ref.listen(authServiceProvider, (previous, next) {
      if (previous != next) {
        authState = next;
        if (authState is SuccessState) {
          ref.read(memberInfoServiceProvider.notifier).getMemberInfo().then(
              (value) => ref
                  .read(orphanageManagementServiceProvider.notifier)
                  .getOrphanageInfo());
        }
      }
    });

    rootTabController.addListener(() {
      if (rootTabController.index == 2 &&
          ref.read(memberInfoServiceProvider) is! SuccessState) {
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
      await ref.read(memberInfoServiceProvider.notifier).getMemberInfo().then(
          (value) => ref
              .read(orphanageManagementServiceProvider.notifier)
              .getOrphanageInfo());
    }
    context.pushNamed(OrphanageManagementScreen.routeName);
  }

  Future navigateToReservationScreen(BuildContext context) async {
    context.pushNamed(ReservationScreen.routeName);
  }

  Future navigateToPostScreen(BuildContext context) async {
    context.pushNamed(PostScreen.routeName);
  }
}
