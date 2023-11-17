import 'package:chrip_aid/auth/dto/user_signup_request_dto.dart';
import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/sign_up_state.dart';
import 'package:chrip_aid/auth/model/type/region.dart';
import 'package:chrip_aid/auth/model/type/region/sub_region.dart';
import 'package:chrip_aid/auth/model/type/sex.dart';
import 'package:chrip_aid/common/component/custom_dropdown_button.dart';
import 'package:chrip_aid/common/utils/snack_bar_util.dart';
import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final userSignUpViewModelProvider = Provider((ref) => UserSignUpViewModel(ref));

class UserSignUpViewModel {
  final Ref ref;

  late AuthService _service;

  final nameTextController = TextEditingController(text: '');
  final idTextController = TextEditingController(text: '');
  final passwordTextController = TextEditingController(text: '');
  final checkPasswordTextController = TextEditingController(text: '');
  final nicknameTextController = TextEditingController(text: '');
  final ageTextController = TextEditingController(text: '');
  final phoneTextController = TextEditingController(text: '');

  late final CustomDropdownButtonController<Sex> sexDropdownController;
  late final CustomDropdownButtonController<MajorRegion>
      majorRegionDropdownController;
  late final CustomDropdownButtonController<SubRegion>
      subRegionDropdownController;

  final SignUpState state = SignUpState();

  UserSignUpViewModel(this.ref) {
    _service = ref.read(authServiceProvider);

    sexDropdownController = CustomDropdownButtonController(
      Sex.values,
    );
    majorRegionDropdownController = CustomDropdownButtonController(
      MajorRegion.values,
      onChanged: (_) {
        subRegionDropdownController.items =
            majorRegionDropdownController.selected.subTypes;
      },
    );
    subRegionDropdownController = CustomDropdownButtonController(
      majorRegionDropdownController.selected.subTypes,
    );
  }

  void signup(BuildContext context) async {
    if (passwordTextController.text != checkPasswordTextController.text) {
      return SnackBarUtil.showError("비밀번호가 일치하지 않습니다.");
    }
    state.withResponse(_service.signup(
      UserSignupRequestDto(
        name: nameTextController.text,
        email: idTextController.text,
        password: passwordTextController.text,
        sex: sexDropdownController.selected.value,
        age: int.parse(ageTextController.text),
        nickname: nicknameTextController.text,
        region: subRegionDropdownController.selected.toJson(),
        phoneNumber: phoneTextController.text,
        // TODO : user profile image
        profilePhoto: 'https://picsum.photos/300/300',
      ),
    ));
    if (context.mounted) context.pop();
  }
}
