import 'package:chrip_aid/orphanage/model/entity/add_basket_item_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_basket_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/update_basket_item_entity.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_basket_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageBasketViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageBasketViewModel(ref));

class OrphanageBasketViewModel extends ChangeNotifier {
  Ref ref;

  late OrphanageState state;

  List<OrphanageBasketEntity> get entity =>
      (state as OrphanageBasketStateSuccess).data;

  int get total => calculateSumOfElements();

  OrphanageBasketViewModel(this.ref) {
    state = ref.read(orphanageBasketServiceProvider);
    ref.listen(orphanageBasketServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        notifyListeners();
      }
    });
  }

  int calculateSumOfElements() {
    int sum = 0;
    for (OrphanageBasketEntity entityItem in entity) {
      sum += (entityItem.price * entityItem.count);
    }
    return sum;
  }

  void updateBasket(int count, int requestId) {
    ref.read(orphanageBasketServiceProvider.notifier).updateOrphanageBasket(
        entity: UpdateBasketItemEntity(count, requestId));
  }

  void deleteBasket(int requestId) {
    ref.read(orphanageBasketServiceProvider.notifier).deleteOrphanageBasket(requestId);
  }

  void addOrUpdateBasket(int requestId, int count) {
    bool isNewProduct = true;
    for (OrphanageBasketEntity entityItem in entity) {
      if (entityItem.requestId == requestId) {
        updateBasket(count, requestId);
        isNewProduct = false;
        print("업데이트");
        break;
      }
    }
    if (isNewProduct) {
      ref.read(orphanageBasketServiceProvider.notifier).addOrphanageBasket(
          entity:
              AddBasketItemEntity(requestId: requestId, count: count));
      print("더하기");
    }
  }
}
