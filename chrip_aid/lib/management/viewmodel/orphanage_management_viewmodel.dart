import 'package:chrip_aid/management/model/dto/add_orphanage_product_request_dto.dart';
import 'package:chrip_aid/management/model/service/orphanage_management_service.dart';
import 'package:chrip_aid/management/model/state/orphanage_management_state.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';
import 'package:chrip_aid/management/view/orphanage_edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageManagementViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageEditViewModel(ref));

class OrphanageEditViewModel extends ChangeNotifier {
  Ref ref;

  late OrphanageManagementState managementState;

  OrphanageDetailEntity? get entity =>
      managementState is OrphanageManagementStateSuccess
          ? (managementState as OrphanageManagementStateSuccess).data
          : null;

  List<ProductEntity> get products => OrphanageManagementState.productList;

  OrphanageEditViewModel(this.ref) {
    managementState = ref.read(orphanageManagementServiceProvider);
    ref.listen(orphanageManagementServiceProvider, (previous, next) {
      if (previous != next) {
        managementState = next;
        notifyListeners();
      }
    });
  }

  void navigateToAddProductScreen(
    BuildContext context, {
    AddOrphanageProductRequestDTO? entity,
  }) {
    context.pushNamed(OrphanageEditProductScreen.routeName, extra: entity);
  }
}
