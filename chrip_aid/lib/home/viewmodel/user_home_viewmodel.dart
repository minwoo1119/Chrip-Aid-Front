import 'package:chrip_aid/orphanage/view/orphanage_map_screen.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/reservation/model/service/reservation_service.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final userHomeViewModelProvider = Provider((ref) => UserHomeViewModel(ref));

class UserHomeViewModel {
  Ref ref;

  UserHomeViewModel(this.ref);

  void navigateToSearchScreen(BuildContext context) {
    context.pushNamed(OrphanageMapScreen.routeName);
  }

  void navigateToReservationScreen(BuildContext context) {
    ref.read(reservationServiceProvider).getOrphanageReservation();
    context.pushNamed(ReservationScreen.routeName);
  }

  void navigateToPostScreen(BuildContext context) {
    context.pushNamed(PostScreen.routeName);
  }
}
