import 'package:chrip_aid/orphanage/view/orphanage_map_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_post_screen.dart';
import 'package:chrip_aid/orphanage/view/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final homeViewModelProvider = ChangeNotifierProvider((ref) => HomeViewModel());

class HomeViewModel extends ChangeNotifier {
  Future navigateToSearchScreen(BuildContext context) async {
    context.pushNamed(OrphanageMapScreen.routeName);
  }

  Future navigateToFavoriteScreen(BuildContext context) async {
    context.pushNamed(ReservationScreen.routeName);
  }

  Future navigateToCertificationScreen(BuildContext context) async {
    context.pushNamed(OrphanagePostScreen.routeName);
  }
}
