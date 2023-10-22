import 'package:chrip_aid/orphanage/model/entity/add_basket_item_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/update_basket_item_entity.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/orphanage_basket_entity.dart';
import '../repository/orphanage_basket_repository.dart';

final orphanageBasketServiceProvider =
    StateNotifierProvider<OrphanageBasketService, OrphanageState>((ref) =>
        OrphanageBasketService(ref.watch(orphanageBasketRepositoryProvider)));

class OrphanageBasketService extends StateNotifier<OrphanageState> {
  final OrphanageBasketRepository repository;

  OrphanageBasketService(this.repository)
      : super(OrphanageBasketStateLoading()) {
    getOrphanageBasket();
  }

  Future getOrphanageBasket() async {
    try {
      state = OrphanageBasketStateLoading();
      List<OrphanageBasketEntity> data = await repository.getOrphanageBasket();
      state = OrphanageBasketStateSuccess(data);
    } catch (e) {
      state = OrphanageBasketStateError(e.toString());
    }
  }

  Future updateOrphanageBasket({required UpdateBasketItemEntity entity}) async {
    await repository.updateBasket(entity);
    getOrphanageBasket();
  }

  Future deleteOrphanageBasket(int requestId) async {
    await repository.deleteBasket(requestId);
    getOrphanageBasket();
  }

  Future addOrphanageBasket({required AddBasketItemEntity entity}) async {
    try {
      await repository.addBasket(entity);
      getOrphanageBasket();
    } catch (e) {
      state = OrphanageProductStateError(e.toString());
    }
  }
}
