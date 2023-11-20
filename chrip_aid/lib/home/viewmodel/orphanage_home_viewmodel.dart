import 'package:chrip_aid/management/view/orphanage_management_screen.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/reservation/model/service/orphanage_reservation_service.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageHomeViewModelProvider =
    Provider((ref) => OrphanageHomeViewModel(ref));

class OrphanageHomeViewModel {
  Ref ref;

  OrphanageHomeViewModel(this.ref);

  void navigateToOrphanageScreen(BuildContext context) {
    context.pushNamed(OrphanageManagementScreen.routeName);
  }

  void navigateToReservationScreen(BuildContext context) {
    ref.read(orphanageReservationServiceProvider).getOrphanageVisitReservation();
    context.pushNamed(ReservationScreen.routeName);
  }

  void navigateToPostScreen(BuildContext context) {
    context.pushNamed(PostScreen.routeName);
  }
}
