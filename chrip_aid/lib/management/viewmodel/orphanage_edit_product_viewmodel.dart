import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/management/model/dto/add_orphanage_product_request_dto.dart';
import 'package:chrip_aid/management/model/entity/product_request_entity.dart';
import 'package:chrip_aid/management/model/service/orphanage_management_service.dart';
import 'package:chrip_aid/management/model/state/orphanage_management_state.dart';
import 'package:chrip_aid/management/view/search_product_screen.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageEditProductViewModelProvider =
    Provider((ref) => OrphanageEditProductViewModel(ref));

class OrphanageEditProductViewModel {
  Ref ref;

  TextEditingController messageController = TextEditingController();

  late final OrphanageManagementService _orphanageManagementService;

  OrphanageProductListState productListState = OrphanageProductListState();
  ProductRequestState productState = ProductRequestState();

  List<ProductEntity> get _products => productListState.value ?? [];

  OrphanageEditProductViewModel(this.ref) {
    _orphanageManagementService = ref.read(orphanageManagementServiceProvider);
    // _orphanageManagementService.getProductList();
  }

  void getInfo(String search) => productListState.withResponse(_orphanageManagementService.getProductList(search));

  void onProductDelete() {
    productState.none();
  }

  void onProductSelected(int index) {
    productState.success(value: ProductRequestEntity(
      productListState.value![index],
    ));
  }

  void onCountUpdate(int count) {
    productState.success(value: productState.value!..count = count + 1);
  }

  void openProductModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SearchProductScreen(
        onProductSelected: onProductSelected,
      ),
    );
  }

  void post(BuildContext context) async {
    if (!productState.isSuccess) return;
    await _orphanageManagementService.editOrphanageProduct(
      AddOrphanageProductRequestDTO(
        title: productState.value!.product.title,
        count: productState.value!.count,
        message: messageController.text,
      ),
    );
    if (context.mounted) context.pop();
  }
}
