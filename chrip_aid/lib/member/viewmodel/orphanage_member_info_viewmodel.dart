import 'package:chrip_aid/auth/provider/auth_provider.dart';
import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/member/view/edit_member_info_screen.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/management/model/service/orphanage_management_service.dart';
import 'package:chrip_aid/management/model/state/orphanage_management_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageMemberInfoViewmodelProvider =
    ChangeNotifierProvider((ref) => OrphanageMemberInfoViewmodel(ref));

class OrphanageMemberInfoViewmodel extends ChangeNotifier {
  Ref ref;

  late MemberInfoState memberState;
  late OrphanageManagementState orphanageState;

  OrphanageMemberEntity? get userInfo => memberState is MemberInfoStateSuccess
      ? (memberState as MemberInfoStateSuccess).data as OrphanageMemberEntity
      : null;

  OrphanageDetailEntity? get orphanageInfo =>
      orphanageState is OrphanageManagementStateSuccess
          ? (orphanageState as OrphanageManagementStateSuccess).data
          : null;

  OrphanageMemberInfoViewmodel(this.ref) {
    memberState = ref.read(memberInfoServiceProvider);
    ref.listen(memberInfoServiceProvider, (previous, next) {
      if (previous != next) memberState = next;
    });

    orphanageState = ref.read(orphanageManagementServiceProvider);
    ref.listen(orphanageManagementServiceProvider, (previous, next) {
      if (previous != next) orphanageState = next;
    });
  }

  void navigateToEditUserInfoPage(BuildContext context) {
    context.pushNamed(EditMemberInfoScreen.routeName);
  }

  void logout() {
    ref.read(authProvider).logout();
  }
}
