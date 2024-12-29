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
  late final OrphanageService _orphanageService;
  final secureStorage = FlutterSecureStorage();

  OrphanageDetailState orphanageState = OrphanageDetailState();

  OrphanageEditViewModel(this.ref) {
    _orphanageManagementService = ref.read(orphanageManagementServiceProvider);
    _orphanageService = ref.read(orphanageServiceProvider);
  }

  void getInfo() async {
    int orphanageId =
        int.parse(await secureStorage.read(key: 'orphanageId') as String);
    orphanageState
        .withResponse(_orphanageService.getOrphanageDetail(orphanageId));
  }

  void navigateToAddProductScreen(
    BuildContext context, {
    AddOrphanageProductRequestDTO? entity,
  }) async {
    int orphanageId =
        int.parse(await secureStorage.read(key: 'orphanageId') as String);
    context.pushNamed(OrphanageEditProductScreen.routeName, extra: entity).then(
          (value) => orphanageState
              .withResponse(_orphanageService.getOrphanageDetail(orphanageId)),
        );
  }

  void navigateToEditOrphanageScreen(BuildContext context) async {
    int orphanageId =
        int.parse(await secureStorage.read(key: 'orphanageId') as String);
    context.pushNamed(OrphanageEditInfoScreen.routeName).then(
          (value) => orphanageState
              .withResponse(_orphanageService.getOrphanageDetail(orphanageId)),
        );
  }
}
