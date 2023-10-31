import 'package:chrip_aid/post/view/orphanage_edit_post_screen.dart';
import 'package:chrip_aid/post/view/orphanage_post_screen.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageHomeViewModelProvider = ChangeNotifierProvider((ref) => HomeViewModel());

class HomeViewModel extends ChangeNotifier {
  Future navigateToSearchScreen(BuildContext context) async {
    // TODO : Orphanage Manage Screen
    context.pushNamed(OrphanageEditPostScreen.routeName);
  }

  Future navigateToFavoriteScreen(BuildContext context) async {
    context.pushNamed(ReservationScreen.routeName);
  }

  Future navigateToCertificationScreen(BuildContext context) async {
    context.pushNamed(PostScreen.routeName);
  }
}
