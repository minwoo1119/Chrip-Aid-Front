import 'package:chrip_aid/auth/provider/auth_provider.dart';
import 'package:chrip_aid/member/model/entity/user_entity.dart';
import 'package:chrip_aid/member/model/service/user_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/member/view/edit_member_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final userInfoViewmodelProvider =
    ChangeNotifierProvider((ref) => UserInfoViewmodel(ref));

class UserInfoViewmodel extends ChangeNotifier {
  Ref ref;

  late MemberInfoState state;

  UserEntity? get userInfo => state is MemberInfoStateSuccess
      ? (state as MemberInfoStateSuccess).data as UserEntity
      : null;

  UserInfoViewmodel(this.ref) {
    state = ref.read(userInfoServiceProvider);
    ref.listen(userInfoServiceProvider, (previous, next) {
      if (previous != next) state = next;
    });
  }

  void navigateToEditUserInfoPage(BuildContext context) {
    context.pushNamed(EditMemberInfoScreen.routeName);
  }

  void logout() {
    ref.read(authProvider).logout();
  }
}
