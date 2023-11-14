import 'package:chrip_aid/auth/provider/auth_provider.dart';
import 'package:chrip_aid/common/const/tabs.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/utils/snack_bar_util.dart';
import 'package:chrip_aid/member/model/entity/user_entity.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/member/view/edit_member_info_screen.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_donate_service.dart';
import 'package:chrip_aid/orphanage/view/orphanage_donate_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final userInfoViewmodelProvider =
    ChangeNotifierProvider((ref) => UserInfoViewmodel(ref));

class UserInfoViewmodel extends ChangeNotifier {
  Ref ref;

  late final MemberInfoService _memberInfoService;

  MemberInfoState get memberState => _memberInfoService.memberInfoState;

  UserEntity? get userInfo => memberState.value as UserEntity?;

  UserInfoViewmodel(this.ref) {
    _memberInfoService = ref.read(memberInfoServiceProvider);
    memberState.addListener(notifyListeners);
  }

  void navigateToEditUserInfoPage(BuildContext context) {
    context.pushNamed(EditMemberInfoScreen.routeName);
  }

  void navigateToDonatePage(BuildContext context) async {
    await ref
        .read(orphanageDonateServiceProvider.notifier)
        .getOrphanageDonate();
    context.pushNamed(OrphanageDonateScreen.routeName);
  }

  void logout() {
    _memberInfoService.logout();
    ref.read(authProvider).logout();
  }
}
