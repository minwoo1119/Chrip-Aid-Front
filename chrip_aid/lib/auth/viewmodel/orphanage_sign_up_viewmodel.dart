import 'package:chrip_aid/auth/dto/orphanage_signup_request_dto.dart';
import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/common/utils/snack_bar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageSignUpViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageSignUpViewModel(ref));

class OrphanageSignUpViewModel extends ChangeNotifier {
  final Ref ref;

  late AuthService _service;

  final nameTextController = TextEditingController(text: '');
  final idTextController = TextEditingController(text: '');
  final passwordTextController = TextEditingController(text: '');
  final checkPasswordTextController = TextEditingController(text: '');
  final orphanageNameTextController = TextEditingController(text: '');

  AuthState get state => _service.authState;

  OrphanageSignUpViewModel(this.ref) {
    _service = ref.read(authServiceProvider);
    state.addListener(notifyListeners);
  }

  void signup(BuildContext context) async {
    if (passwordTextController.text != checkPasswordTextController.text) {
      return SnackBarUtil.showError("비밀번호가 일치하지 않습니다.");
    }
    _service.signup(
      OrphanageSignupRequestDto(
        name: nameTextController.text,
        email: idTextController.text,
        password: passwordTextController.text,
        orphanageName: orphanageNameTextController.text,
      ),
    );
    if (context.mounted) context.pop();
  }
}
