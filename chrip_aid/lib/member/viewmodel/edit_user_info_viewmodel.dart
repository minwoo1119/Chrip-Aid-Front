import 'package:chrip_aid/auth/model/type/region.dart';
import 'package:chrip_aid/auth/model/type/region/sub_region.dart';
import 'package:chrip_aid/auth/model/type/sex.dart';
import 'package:chrip_aid/common/component/custom_dropdown_button.dart';
import 'package:chrip_aid/common/utils/snack_bar_util.dart';
import 'package:chrip_aid/member/model/dto/edit_user_info_request_dto.dart';
import 'package:chrip_aid/member/model/entity/user_entity.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final editUserInfoViewModelProvider =
    ChangeNotifierProvider((ref) => EditUserInfoViewModel(ref));

class EditUserInfoViewModel extends ChangeNotifier {
  final Ref ref;

  late final TextEditingController nameTextController;
  late final TextEditingController passwordTextController;
  late final TextEditingController checkPasswordTextController;
  late final TextEditingController nicknameTextController;
  late final TextEditingController ageTextController;
  late final TextEditingController phoneTextController;

  late final CustomDropdownButtonController<Sex> sexDropdownController;
  late final CustomDropdownButtonController<MajorRegion>
      majorRegionDropdownController;
  late final CustomDropdownButtonController<SubRegion>
      subRegionDropdownController;

  late MemberInfoState userInfoState;

  UserEntity? get userInfo => userInfoState is MemberInfoStateSuccess
      ? (userInfoState as MemberInfoStateSuccess).data as UserEntity
      : null;

  EditUserInfoViewModel(this.ref) {
    userInfoState = ref.read(memberInfoServiceProvider);
    ref.listen(memberInfoServiceProvider, (previous, next) {
      if (previous != next) userInfoState = next;
    });

    nameTextController = TextEditingController(text: userInfo!.name);
    passwordTextController = TextEditingController();
    checkPasswordTextController = TextEditingController();
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
      onChanged: (_) {
        subRegionDropdownController.items =
            majorRegionDropdownController.selected.subTypes;
        notifyListeners();
      },
    );
    subRegionDropdownController = CustomDropdownButtonController(
      majorRegionDropdownController.selected.subTypes,
      initIndex: userInfo!.region.majorRegion.subTypes.indexOf(
        userInfo!.region,
      ),
      onChanged: (_) => notifyListeners(),
    );
  }

  void editUserInfo(BuildContext context) async {
    if (passwordTextController.text != checkPasswordTextController.text) {
      return SnackBarUtil.showError("비밀번호가 일치하지 않습니다.");
    }
    await ref.read(memberInfoServiceProvider.notifier).editMemberInfo(
          EditUserInfoRequestDto(
            name: nameTextController.text,
            password: passwordTextController.text,
            nickName: nicknameTextController.text,
            age: int.parse(ageTextController.text),
            sex: sexDropdownController.selected,
            region: subRegionDropdownController.selected,
            phone: phoneTextController.text,
            profileUrl: 'https://picsum.photos/300/300',
          ),
        );
    if (context.mounted) context.pop();
  }
}
