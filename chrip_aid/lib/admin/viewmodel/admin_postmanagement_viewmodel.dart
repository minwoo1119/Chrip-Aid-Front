import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/service/admin_postmanagement_service.dart';

final adminPostManagementViewModelProvider =
Provider((ref) => AdminPostmanagementViewmodel(ref));

class AdminPostmanagementViewmodel {
  Ref ref;
  late final AdminPostManagementService _adminAccountManagementServiceManagementService;

  OrphanageDetailState orphanageState = OrphanageDetailState();

  AdminPostmanagementViewmodel(this.ref) {
    _adminAccountManagementServiceManagementService = ref.read(adminPostManagementServiceProvider);
  }

}
