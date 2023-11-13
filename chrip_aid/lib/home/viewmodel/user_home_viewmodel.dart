import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/common/const/tabs.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_service.dart';
import 'package:chrip_aid/orphanage/view/orphanage_map_screen.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/reservation/model/repository/reservation_repository.dart';
import 'package:chrip_aid/reservation/model/service/orphanage_reservation_service.dart';
import 'package:chrip_aid/reservation/model/service/reservation_service.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final userHomeViewModelProvider = ChangeNotifierProvider((ref) => UserHomeViewModel(ref));

class UserHomeViewModel extends ChangeNotifier {
  Ref ref;

  late AuthState authState;

  UserHomeViewModel(this.ref) {
    authState = ref.read(authServiceProvider);
    ref.listen(authServiceProvider, (previous, next) {
      if(previous != next) {
        authState = next;
        if(authState is SuccessState) {
          ref.read(memberInfoServiceProvider.notifier).getMemberInfo();
        }
      }
    });

    rootTabController.addListener(() {
      if (rootTabController.index == 2 && ref.read(memberInfoServiceProvider) is! SuccessState) {
        ref.read(memberInfoServiceProvider.notifier).getMemberInfo();
      }
    });
  }

  Future navigateToSearchScreen(BuildContext context) async {
    if(ref.read(memberInfoServiceProvider) is! SuccessState) {
      await ref.read(memberInfoServiceProvider.notifier).getMemberInfo();
    }
    ref.read(orphanageServiceProvider.notifier).getOrphanageList();
    context.pushNamed(OrphanageMapScreen.routeName);
  }

  Future navigateToFavoriteScreen(BuildContext context) async {
    await ref.read(reservationServiceProvider.notifier).getOrphanageReservation();
    context.pushNamed(ReservationScreen.routeName);
  }

  Future navigateToCertificationScreen(BuildContext context) async {
    context.pushNamed(PostScreen.routeName);
  }
}
