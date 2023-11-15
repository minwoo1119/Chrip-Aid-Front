import 'package:chrip_aid/orphanage/model/dto/donate_delete_dto.dart';
import 'package:chrip_aid/orphanage/model/dto/donate_request_dto.dart';
import 'package:chrip_aid/orphanage/model/entity/add_basket_item_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/update_basket_item_entity.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/orphanage_basket_entity.dart';
import '../repository/orphanage_basket_repository.dart';

final orphanageBasketServiceProvider = Provider((ref) {
  final repository = ref.watch(orphanageBasketRepositoryProvider);
  return OrphanageBasketService(repository);
});

class OrphanageBasketService {
  final OrphanageBasketRepository repository;

  final OrphanageBasketState orphanageBasketState = OrphanageBasketState();

  OrphanageBasketService(this.repository);

  Future getOrphanageBasket() async {
    try {
      orphanageBasketState.loading();
      List<OrphanageBasketEntity> data = await repository.getOrphanageBasket();
      orphanageBasketState.success(value: data);
    } catch (e) {
      orphanageBasketState.error(message: e.toString());
    }
  }

  Future updateOrphanageBasket({required UpdateBasketItemEntity entity}) async {
    await repository.updateBasket(entity);
    getOrphanageBasket();
  }

  Future deleteOrphanageBasket(DonateDeleteDto dto) async {
    await repository.deleteBasket(dto);
    getOrphanageBasket();
  }

  Future addOrphanageBasket({required AddBasketItemEntity entity}) async {
    try {
      await repository.addBasket(entity);
      getOrphanageBasket();
    } catch (e) {
      orphanageBasketState.error(message: e.toString());
    }
  }

  Future donate(DonateRequestDTO dto) async {
    try {
      orphanageBasketState.loading();
      await repository.donate(dto);
      getOrphanageBasket();
    } catch (e) {
      orphanageBasketState.error(message: e.toString());
    }
  }
}
