import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>(
  (ref) => AuthProvider(ref: ref),
);

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  late AuthService _service;

  AuthState get authState => _service.authState;

  AuthProvider({required this.ref}) {
    _service = ref.read(authServiceProvider);
    authState.addListener(notifyListeners);
  }

  String? redirectLogic(BuildContext context, GoRouterState state) {
    final isLoginScreen = state.location.contains('/auth');

    if (authState.isNone) {
      return isLoginScreen ? null : '/auth';
    }

    if (authState.isSuccess) {
      return isLoginScreen || state.location == '/splash' ? '/' : null;
    }

    if (authState.isError) {
      return isLoginScreen ? null : '/auth';
    }

    return null;
  }

  void logout() => _service.logout();
}
