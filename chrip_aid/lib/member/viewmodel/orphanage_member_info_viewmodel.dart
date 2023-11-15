import 'package:chrip_aid/auth/provider/auth_provider.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/utils/snack_bar_util.dart';
import 'package:chrip_aid/management/model/service/orphanage_management_service.dart';
import 'package:chrip_aid/management/model/state/orphanage_management_state.dart';
import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/member/view/edit_member_info_screen.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_donate_service.dart';
import 'package:chrip_aid/orphanage/view/orphanage_donate_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageMemberInfoViewmodelProvider =
    ChangeNotifierProvider((ref) => OrphanageMemberInfoViewmodel(ref));

class OrphanageMemberInfoViewmodel extends ChangeNotifier {
  Ref ref;

  late final MemberInfoService _memberInfoService;

  MemberInfoState get memberState => _memberInfoService.memberInfoState;

  late OrphanageManagementState orphanageState;

  OrphanageMemberEntity? get userInfo => memberState.value as OrphanageMemberEntity?;

  OrphanageDetailEntity? get orphanageInfo =>
      orphanageState is OrphanageManagementStateSuccess
          ? (orphanageState as OrphanageManagementStateSuccess).data
          : null;

  OrphanageMemberInfoViewmodel(this.ref) {
    _memberInfoService = ref.read(memberInfoServiceProvider);
    memberState.addListener(() {
      if (memberState.isError) {
        SnackBarUtil.showError((memberState as ErrorState).message);
      }
      if(memberState.isSuccess) {
        ref.read(orphanageManagementServiceProvider.notifier).getOrphanageInfo();
      }
    });

    orphanageState = ref.read(orphanageManagementServiceProvider);
    ref.listen(orphanageManagementServiceProvider, (previous, next) {
      if (previous != next) {
        orphanageState = next;
        notifyListeners();
      }
    });
  }

  void navigateToEditUserInfoPage(BuildContext context) {
    context.pushNamed(EditMemberInfoScreen.routeName);
  }

  void logout() {
    _memberInfoService.logout();
    ref.read(authProvider).logout();
  }

  void navigateToDonatePage(BuildContext context) async {
    ref.read(orphanageDonateServiceProvider).getOrphanageDonate();
    if(context.mounted) context.pushNamed(OrphanageDonateScreen.routeName);
  }
}
