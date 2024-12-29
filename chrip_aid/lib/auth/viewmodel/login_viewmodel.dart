import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/auth/model/state/authority_state.dart';
import 'package:chrip_aid/auth/view/sign_up_screen.dart';
import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final loginViewModelProvider = Provider((ref) => LoginViewModel(ref));

class LoginViewModel {
  final Ref ref;
  late AuthService _service;

  final AuthState authState = AuthState();

  final AuthorityState authorityState = AuthorityState();

  final idTextController = TextEditingController(text: '');
  final passwordTextController = TextEditingController(text: '');

  LoginViewModel(this.ref) {
    _service = ref.read(authServiceProvider);
  }

  void getInfo() {
    authState.withResponse(_service.saveFcmToken());
  }

  void toggleAuthorityType() => toggleAuthority();

  void login(BuildContext context) {
    final isOrphanage = authorityState.value == AuthorityType.orphanage;

    authState.withResponse(_service.login(
      context: context,
      id: idTextController.text,
      password: passwordTextController.text,
      isOrphanage: isOrphanage
    ));
  }

  void logout() {
    authState.withResponse(_service.logout());
  }

  void navigateToSignupPage(BuildContext context) {
    context.pushNamed(SignUpScreen.routeName);
  }
}
