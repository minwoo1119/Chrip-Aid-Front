import 'package:chrip_aid/auth/model/entity/user_entity.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/auth/model/type/region.dart';
import 'package:chrip_aid/auth/model/type/region/sub_region.dart';
import 'package:chrip_aid/auth/model/type/sex.dart';
import 'package:chrip_aid/common/component/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final editUserInfoViewModelProvider =
ChangeNotifierProvider((ref) => EditUserInfoViewModel(ref));

class EditUserInfoViewModel extends ChangeNotifier {
  final Ref ref;

  final nameTextController = TextEditingController(text: '');
  final idTextController = TextEditingController(text: '');
  final passwordTextController = TextEditingController(text: '');
  final checkPasswordTextController = TextEditingController(text: '');
  final nicknameTextController = TextEditingController(text: '');
  final ageTextController = TextEditingController(text: '');
  final phoneTextController = TextEditingController(text: '');

  late final CustomDropdownButtonController<Sex> sexDropdownController;
  late final CustomDropdownButtonController<MajorRegion> majorRegionDropdownController;
  late final CustomDropdownButtonController<SubRegion> subRegionDropdownController;

  late AuthState state;

  UserEntity? get userInfo =>
      state is AuthStateSuccess ? (state as AuthStateSuccess).data : null;

  EditUserInfoViewModel(this.ref) {
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
    if(context.mounted) context.pop();
  }
}
