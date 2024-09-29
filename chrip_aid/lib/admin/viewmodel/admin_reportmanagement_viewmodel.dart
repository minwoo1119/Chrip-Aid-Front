import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/management/model/dto/add_orphanage_product_request_dto.dart';
import 'package:chrip_aid/management/view/orphanage_edit_info_screen.dart';
import 'package:chrip_aid/management/view/orphanage_edit_product_screen.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../model/service/admin_reportmanagement_service.dart';

final adminReportManagementViewModelProvider =
Provider((ref) => AdminReportmanagementViewmodel(ref));

class AdminReportmanagementViewmodel {
  Ref ref;
  late final AdminReportmanagementService _adminReportManagementServiceManagementService;

  OrphanageDetailState orphanageState = OrphanageDetailState();

  AdminReportmanagementViewmodel(this.ref) {
    _adminReportManagementServiceManagementService = ref.read(adminReportManagementServiceProvider);
  }

  void getInfo() => orphanageState
      .withResponse(_adminReportManagementServiceManagementService.getOrphanageInfo());

  void navigateToAddProductScreen(
      BuildContext context, {
        AddOrphanageProductRequestDTO? entity,
      }) {
    context.pushNamed(OrphanageEditProductScreen.routeName, extra: entity).then(
          (value) => orphanageState
          .withResponse(_adminReportManagementServiceManagementService.getOrphanageInfo()),
    );
  }

  void navigateToEditOrphanageScreen(BuildContext context) {
    context.pushNamed(OrphanageEditInfoScreen.routeName).then(
          (value) => orphanageState
          .withResponse(_adminReportManagementServiceManagementService.getOrphanageInfo()),
    );
  }
}
