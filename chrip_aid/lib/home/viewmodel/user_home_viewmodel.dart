import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/orphanage/view/orphanage_map_screen.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
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

    if (authState is SuccessState) {
      ref.read(memberInfoServiceProvider.notifier).getMemberInfo();
    }
  }

  Future navigateToSearchScreen(BuildContext context) async {
    context.pushNamed(OrphanageMapScreen.routeName);
  }

  Future navigateToFavoriteScreen(BuildContext context) async {
    context.pushNamed(ReservationScreen.routeName);
  }

  Future navigateToCertificationScreen(BuildContext context) async {
    context.pushNamed(PostScreen.routeName);
  }
}
