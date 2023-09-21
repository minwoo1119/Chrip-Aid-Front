import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/common/component/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final signUpViewModelProvider =
    ChangeNotifierProvider((ref) => SignUpViewModel(ref));

class SignUpViewModel extends ChangeNotifier {
  final Ref ref;

  final idTextController = TextEditingController(text: '');
  final passwordTextController = TextEditingController(text: '');
  final checkPasswordTextController = TextEditingController(text: '');
  final nicknameTextController = TextEditingController(text: '');
  final phoneTextController = TextEditingController(text: '');

  late final CustomDropdownButtonController sexDropdownController;
  late final CustomDropdownButtonController locationDropdownController;

  late AuthState state;

  SignUpViewModel(this.ref) {
    state = ref.read(authServiceProvider);
    ref.listen(authServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        notifyListeners();
      }
    });

    sexDropdownController = CustomDropdownButtonController(
      ["남", "여"],
      onChanged: (_) => notifyListeners(),
    );
    locationDropdownController = CustomDropdownButtonController(
      ["구미", "대구", "경산", "파주"],
      onChanged: (_) => notifyListeners(),
    );
  }

  void signup(BuildContext context) {
    context.pop();
  }
}
