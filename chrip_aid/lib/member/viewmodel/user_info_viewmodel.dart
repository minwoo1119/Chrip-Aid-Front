import 'package:chrip_aid/auth/provider/auth_provider.dart';
import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/member/view/edit_member_info_screen.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_donate_service.dart';
import 'package:chrip_aid/orphanage/view/orphanage_donate_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final userInfoViewmodelProvider = Provider((ref) => UserInfoViewmodel(ref));

class UserInfoViewmodel {
  Ref ref;

  late final MemberInfoService _memberInfoService;

  final MemberInfoState memberState = MemberInfoState();

  UserInfoViewmodel(this.ref) {
    _memberInfoService = ref.read(memberInfoServiceProvider);
  }

  void getInfo() {
    if (!memberState.isSuccess) {
      memberState.withResponse(_memberInfoService.getMemberInfo());
    }
  }

  void navigateToEditUserInfoPage(BuildContext context) {
    context.pushNamed(EditMemberInfoScreen.routeName);
  }

  void navigateToDonatePage(BuildContext context) async {
    await ref.read(orphanageDonateServiceProvider).getOrphanageDonate();
    if (context.mounted) context.pushNamed(OrphanageDonateScreen.routeName);
  }

  void logout() => ref.read(authProvider).logout();
}