import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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


}
