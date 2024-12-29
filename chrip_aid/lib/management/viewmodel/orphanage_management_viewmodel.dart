import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/management/model/dto/add_orphanage_product_request_dto.dart';
import 'package:chrip_aid/management/model/service/orphanage_management_service.dart';
import 'package:chrip_aid/management/view/orphanage_edit_info_screen.dart';
import 'package:chrip_aid/management/view/orphanage_edit_product_screen.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

final orphanageManagementViewModelProvider =
    Provider((ref) => OrphanageEditViewModel(ref));

class OrphanageEditViewModel {
  Ref ref;

  late final OrphanageManagementService _orphanageManagementService;
  late final OrphanageService _orphanaggeService;

  OrphanageDetailState orphanageState = OrphanageDetailState();

  OrphanageEditViewModel(this.ref) {
    _orphanageManagementService = ref.read(orphanageManagementServiceProvider);
    _orphanaggeService = ref.read(orphanageServiceProvider);
  }

  void getInfso() => orphanageState
      .withResponse(_orphanageManagementService.getOrphanageInfo());

  void getInfo() async {
    final secureStorage = FlutterSecureStorage();
    int orphanageId = int.parse(await secureStorage.read(key: 'orphanageId') as String);
    orphanageState.withResponse(_orphanaggeService.getOrphanageDetail(orphanageId));
  }

  void navigateToAddProductScreen(
    BuildContext context, {
    AddOrphanageProductRequestDTO? entity,
  }) {
    context.pushNamed(OrphanageEditProductScreen.routeName, extra: entity).then(
          (value) => orphanageState
              .withResponse(_orphanageManagementService.getOrphanageInfo()),
        );
  }

  void navigateToEditOrphanageScreen(BuildContext context) {
    context.pushNamed(OrphanageEditInfoScreen.routeName).then(
          (value) => orphanageState
              .withResponse(_orphanageManagementService.getOrphanageInfo()),
        );
  }
}
