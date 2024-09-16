import 'package:chrip_aid/orphanage/view/orphanage_map_screen.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:chrip_aid/supervisor/viewmodel/superviser_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final supervisorHomeViewModelProvider = Provider((ref) => SupervisorViewModel(ref));

class SupervisorViewModel {
  Ref ref;

  SupervisorViewModel(this.ref);

  // TODO : 아래 세 함수들 수정해야함
  void navigateToSearchScreen(BuildContext context) {
    context.pushNamed(OrphanageMapScreen.routeName);
  }

  void navigateToReservationScreen(BuildContext context) {
    context.pushNamed(ReservationScreen.routeName);
  }

  void navigateToPostScreen(BuildContext context) {
    context.pushNamed(PostScreen.routeName);
  }
}
