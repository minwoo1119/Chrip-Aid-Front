import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final homeViewModelProvider = ChangeNotifierProvider((ref) => HomeViewModel());

class HomeViewModel extends ChangeNotifier {
  Future navigateToSearchScreen(BuildContext context) async {
    context.push("/orphanage/map");
  }

  Future navigateToFavoriteScreen(BuildContext context) async {
    context.pushNamed("/orphanage");
  }

  Future navigateToCertificationScreen(BuildContext context) async {}
}
