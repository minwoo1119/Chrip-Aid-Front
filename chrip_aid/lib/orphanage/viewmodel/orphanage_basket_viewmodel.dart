import 'package:chrip_aid/common/kakao/kakao_pay.dart';
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

  late final OrphanageBasketService _orphanageBasketService;

  OrphanageBasketState get orphanageBasketState =>
      _orphanageBasketService.orphanageBasketState;

  List<OrphanageBasketEntity>? get entities => orphanageBasketState.value;

  int get total => calculateSumOfElements();

  OrphanageBasketViewModel(this.ref) {
    _orphanageBasketService = ref.read(orphanageBasketServiceProvider);
    orphanageBasketState.addListener(notifyListeners);
  }

  int calculateSumOfElements() {
    int sum = 0;
    for (OrphanageBasketEntity entityItem in entities!) {
      sum += (entityItem.price * entityItem.count);
    }
    return sum;
  }

  void updateBasket(int count, int requestId) {
    _orphanageBasketService.updateOrphanageBasket(
      entity: UpdateBasketItemEntity(count, requestId),
    );
  }

  void deleteBasket(int basketProductId) {
    _orphanageBasketService.deleteOrphanageBasket(
      DonateDeleteDto(basketProductId: basketProductId),
    );
  }

  void addOrUpdateBasket(int requestId, int count) async {
    bool isNewProduct = true;
    if (orphanageBasketState.isSuccess) {
      await _orphanageBasketService.getOrphanageBasket();
    }
    for (OrphanageBasketEntity entityItem in entities!) {
      if (entityItem.requestId == requestId) {
        updateBasket(count, requestId);
        isNewProduct = false;
        break;
      }
    }
    if (isNewProduct) {
      _orphanageBasketService.addOrphanageBasket(
        entity: AddBasketItemEntity(requestId: requestId, count: count),
      );
    }
  }

  void payment(BuildContext context) async {
    await kakaoPayReady(
      "${entities!.first.productName} 등",
      entities!.map((e) => e.count).reduce((value, element) => value + element),
      entities!
          .map((e) => e.count * e.price)
          .reduce((value, element) => value + element),
    );
    await _orphanageBasketService.donate(
      DonateRequestDTO(
        basketProductIds: entities!.map((e) => e.basketProductId).toList(),
        message: '',
      ),
    );
    if(context.mounted) context.pop();
  }
}
