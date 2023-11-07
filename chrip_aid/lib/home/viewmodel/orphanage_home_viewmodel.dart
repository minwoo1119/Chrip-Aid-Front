import 'package:chrip_aid/management/view/orphanage_management_screen.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageHomeViewModelProvider =
    ChangeNotifierProvider((ref) => HomeViewModel(ref));

class HomeViewModel extends ChangeNotifier {
  Ref ref;

  HomeViewModel(this.ref);

  Future navigateToOrphanageScreen(BuildContext context) async {
    context.pushNamed(OrphanageManagementScreen.routeName);
  }

  Future navigateToReservationScreen(BuildContext context) async {
    context.pushNamed(ReservationScreen.routeName);
  }

  Future navigateToPostScreen(BuildContext context) async {
    context.pushNamed(PostScreen.routeName);
  }
}
