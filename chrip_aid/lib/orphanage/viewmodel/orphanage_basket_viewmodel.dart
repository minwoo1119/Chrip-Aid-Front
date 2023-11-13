import 'package:chrip_aid/common/kakao/kakao_pay.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/orphanage/model/dto/donate_delete_dto.dart';
import 'package:chrip_aid/orphanage/model/dto/donate_request_dto.dart';
import 'package:chrip_aid/orphanage/model/entity/add_basket_item_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_basket_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/update_basket_item_entity.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_basket_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageBasketViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageBasketViewModel(ref));

class OrphanageBasketViewModel extends ChangeNotifier {
  Ref ref;

  late OrphanageState state;

  List<OrphanageBasketEntity>? get entity =>
      state is OrphanageBasketStateSuccess
          ? (state as OrphanageBasketStateSuccess).data
          : null;

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
    for (OrphanageBasketEntity entityItem in entity!) {
      sum += (entityItem.price * entityItem.count);
    }
    return sum;
  }

  void updateBasket(int count, int requestId) {
    ref.read(orphanageBasketServiceProvider.notifier).updateOrphanageBasket(
        entity: UpdateBasketItemEntity(count, requestId));
  }

  void deleteBasket(int basketProductId) {
    ref
        .read(orphanageBasketServiceProvider.notifier)
        .deleteOrphanageBasket(DonateDeleteDto(basketProductId: basketProductId));
  }

  void addOrUpdateBasket(int requestId, int count) async {
    bool isNewProduct = true;
    if(state is! SuccessState) {
      await ref.read(orphanageBasketServiceProvider.notifier).getOrphanageBasket();
    }
    for (OrphanageBasketEntity entityItem in entity!) {
      if (entityItem.requestId == requestId) {
        updateBasket(count, requestId);
        isNewProduct = false;
        break;
      }
    }
    if (isNewProduct) {
      ref.read(orphanageBasketServiceProvider.notifier).addOrphanageBasket(
            entity: AddBasketItemEntity(requestId: requestId, count: count),
          );
    }
  }

  void payment(BuildContext context) async {
    await kakaoPayReady(
      "${entity!.first.productName} 등",
      entity!.map((e) => e.count).reduce((value, element) => value + element),
      entity!
          .map((e) => e.count * e.price)
          .reduce((value, element) => value + element),
    );
    await ref.read(orphanageBasketServiceProvider.notifier).donate(
          DonateRequestDTO(
            basketProductIds: entity!.map((e) => e.basketProductId).toList(),
            message: '',
          ),
        );
    context.pop();
  }
}
