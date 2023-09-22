import 'package:chrip_aid/auth/model/entity/user_entity.dart';
import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/auth/model/type/region.dart';
import 'package:chrip_aid/auth/model/type/region/sub_region.dart';
import 'package:chrip_aid/auth/model/type/sex.dart';
import 'package:chrip_aid/common/component/custom_dropdown_button.dart';
import 'package:chrip_aid/member/model/dto/edit_user_info_request_dto.dart';
import 'package:chrip_aid/member/model/service/user_info_service.dart';
import 'package:chrip_aid/member/model/state/user_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final editUserInfoViewModelProvider =
    ChangeNotifierProvider((ref) => EditUserInfoViewModel(ref));

class EditUserInfoViewModel extends ChangeNotifier {
  final Ref ref;

  late final TextEditingController nameTextController;
  late final TextEditingController nicknameTextController;
  late final TextEditingController ageTextController;
  late final TextEditingController phoneTextController;

  late final CustomDropdownButtonController<Sex> sexDropdownController;
  late final CustomDropdownButtonController<MajorRegion>
      majorRegionDropdownController;
  late final CustomDropdownButtonController<SubRegion>
      subRegionDropdownController;

  late AuthState authState;
  late UserInfoState userInfoState;

  UserEntity? get userInfo => authState is AuthStateSuccess
      ? (authState as AuthStateSuccess).data
      : null;

  EditUserInfoViewModel(this.ref) {
    authState = ref.read(authServiceProvider);
    ref.listen(authServiceProvider, (previous, next) {
      if (previous != next) authState = next;
    });

    userInfoState = ref.read(userInfoServiceProvider);
    ref.listen(userInfoServiceProvider, (previous, next) {
      if (previous != next) userInfoState = next;
    });

    nameTextController = TextEditingController(text: userInfo!.name);
    nicknameTextController = TextEditingController(text: userInfo!.nickName);
    ageTextController = TextEditingController(text: userInfo!.age.toString());
    phoneTextController = TextEditingController(text: userInfo!.phone);

    sexDropdownController = CustomDropdownButtonController(
      Sex.values,
      initIndex: Sex.values.indexOf(userInfo!.sex),
      onChanged: (_) => notifyListeners(),
    );
    majorRegionDropdownController = CustomDropdownButtonController(
      MajorRegion.values,
      initIndex: MajorRegion.values.indexOf(userInfo!.region.majorRegion),
      onChanged: (_) => notifyListeners(),
    );
    subRegionDropdownController = CustomDropdownButtonController(
      userInfo!.region.majorRegion.subTypes,
      initIndex: userInfo!.region.majorRegion.subTypes.indexOf(
        userInfo!.region,
      ),
      onChanged: (_) => notifyListeners(),
    );
  }

  void editUserInfo(BuildContext context) async {
    await ref.read(userInfoServiceProvider.notifier).editUserInfo(
          EditUserInfoRequestDto(
            name: nameTextController.text,
            nickName: nicknameTextController.text,
            age: int.parse(ageTextController.text),
            sex: sexDropdownController.selected,
            region: subRegionDropdownController.selected,
            phone: phoneTextController.text,
            profileUrl: '',
          ),
        );
    await ref.read(authServiceProvider.notifier).getUserInfo();
    if (context.mounted) context.pop();
  }
}
