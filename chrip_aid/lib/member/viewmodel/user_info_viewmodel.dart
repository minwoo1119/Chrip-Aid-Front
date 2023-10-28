import 'package:chrip_aid/auth/model/entity/user_entity.dart';
import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/member/view/edit_member_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final userInfoViewmodelProvider =
    ChangeNotifierProvider((ref) => UserInfoViewmodel(ref));

class UserInfoViewmodel extends ChangeNotifier {
  Ref ref;

  late AuthState state;

  UserEntity? get userInfo =>
      state is AuthStateSuccess ? (state as AuthStateSuccess).data : null;

  UserInfoViewmodel(this.ref) {
    state = ref.read(authServiceProvider);
    ref.listen(authServiceProvider, (previous, next) {
      if(previous != next) state = next;
    });
  }

  void navigateToEditUserInfoPage(BuildContext context) {
    context.pushNamed(EditMemberInfoScreen.routeName);
  }
}
