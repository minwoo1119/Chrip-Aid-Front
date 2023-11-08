import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/auth/provider/user_type_provider.dart';
import 'package:chrip_aid/auth/view/sign_up_screen.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/utils/snack_bar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final loginViewModelProvider =
    ChangeNotifierProvider((ref) => LoginViewModel(ref));

class LoginViewModel extends ChangeNotifier {
  final Ref ref;
  late AuthState state;
  late AuthorityType authority;

  final idTextController = TextEditingController(text: '');
  final passwordTextController = TextEditingController(text: '');

  LoginViewModel(this.ref) {
    state = ref.read(authServiceProvider);
    ref.listen<AuthState>(authServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        if (state is ErrorState) {
          SnackBarUtil.showError((state as ErrorState).message);
        }
        notifyListeners();
      }
    });

    authority = ref.read(authorityProvider);
    ref.listen(authorityProvider, (previous, next) {
      if (previous != next) {
        authority = next;
        notifyListeners();
      }
    });
  }

  void toggleAuthorityType(bool? isAuthority) {
    if (isAuthority == true) {
      ref.read(authorityProvider.notifier).state = AuthorityType.orphanage;
    } else {
      ref.read(authorityProvider.notifier).state = AuthorityType.user;
    }
  }

  void login() {
    ref.read(authServiceProvider.notifier).login(
          id: idTextController.text,
          password: passwordTextController.text,
        );
  }

  void logout() {
    ref.read(authServiceProvider.notifier).logout();
  }

  void navigateToSignupPage(BuildContext context) {
    context.pushNamed(SignUpScreen.routeName);
  }
}
