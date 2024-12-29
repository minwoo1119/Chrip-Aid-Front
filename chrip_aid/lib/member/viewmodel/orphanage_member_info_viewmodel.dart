import 'package:chrip_aid/auth/provider/auth_provider.dart';
import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/management/model/service/orphanage_management_service.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/member/view/edit_member_info_screen.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_donate_service.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:chrip_aid/orphanage/view/orphanage_donate_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

final orphanageMemberInfoViewmodelProvider =
    Provider((ref) => OrphanageMemberInfoViewmodel(ref));

class OrphanageMemberInfoViewmodel {
  Ref ref;

  late final MemberInfoService _memberInfoService;
  late final OrphanageManagementService _orphanageManagementService;
  late final OrphanageService _orphanageService;

  final MemberInfoState memberState = MemberInfoState();

  OrphanageDetailState orphanageDetailState = OrphanageDetailState();

  OrphanageMemberInfoViewmodel(this.ref) {
    _memberInfoService = ref.read(memberInfoServiceProvider);
    _orphanageService = ref.read(orphanageServiceProvider);

    memberState.addListener(() {
      if (memberState.isSuccess) {
        _orphanageManagementService.getOrphanageInfo();
      }
    });

    _orphanageManagementService = ref.read(orphanageManagementServiceProvider);
  }

  void getInfo() async {
    // Flutter Secure Storage 초기화
    final secureStorage = FlutterSecureStorage();

    if (!memberState.isSuccess) {
      memberState.withResponse(_memberInfoService.getMemberInfo());
    }

    int orphanageId = int.parse(await secureStorage.read(key: 'orphanageId') as String);

    orphanageDetailState.withResponse(
      _orphanageService.getOrphanageDetail(orphanageId),
    );
  }

  void navigateToEditUserInfoPage(BuildContext context) {
    context.pushNamed(EditMemberInfoScreen.routeName);
  }

  void logout() {
    ref.read(authProvider).logout();
  }

  void navigateToDonatePage(BuildContext context) async {
    ref.read(orphanageDonateServiceProvider).getOrphanageDonate();
    if (context.mounted) context.pushNamed(OrphanageDonateScreen.routeName);
  }
}
