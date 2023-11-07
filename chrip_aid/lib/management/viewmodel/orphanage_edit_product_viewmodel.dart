import 'package:chrip_aid/management/model/dto/add_orphanage_product_request_dto.dart';
import 'package:chrip_aid/management/model/service/orphanage_management_service.dart';
import 'package:chrip_aid/management/model/state/orphanage_management_state.dart';
import 'package:chrip_aid/management/view/search_product_screen.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageEditProductViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageEditProductViewModel(ref));

class OrphanageEditProductViewModel extends ChangeNotifier {
  Ref ref;

  TextEditingController messageController = TextEditingController();

  late OrphanageManagementState state;

  List<ProductEntity> get products => OrphanageManagementState.productList;

  ProductEntity? get product =>
      productIndex == -1 ? null : products[productIndex];
  int productIndex = -1;
  int productCount = 1;

  OrphanageEditProductViewModel(this.ref) {
    state = ref.read(orphanageManagementServiceProvider);
    ref.listen(orphanageManagementServiceProvider, (previous, next) {
      if (previous != next) state = next;
      notifyListeners();
    });
  }

  void onProductDelete() {
    productIndex = -1;
    notifyListeners();
  }

  void onProductSelected(int index) {
    productIndex = index;
    productCount = 1;
    notifyListeners();
  }

  void onCountUpdate(int count) {
    productCount = count;
  }

  void openProductModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SearchProductScreen(
        products: products,
        onProductSelected: onProductSelected,
      ),
    );
    notifyListeners();
  }

  void post(BuildContext context) {
    if (product == null) return;
    ref
        .read(orphanageManagementServiceProvider.notifier)
        .editOrphanageProduct(
          AddOrphanageProductRequestDTO(
            id: product!.id,
            count: productCount,
            message: messageController.text,
          ),
        )
        .then((value) => context.pop());
  }
}
