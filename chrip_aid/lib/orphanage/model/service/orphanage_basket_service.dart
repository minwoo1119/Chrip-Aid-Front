import 'package:chrip_aid/orphanage/model/dto/donate_delete_dto.dart';
import 'package:chrip_aid/orphanage/model/dto/donate_request_dto.dart';
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
      : super(OrphanageStateNone());

  Future getOrphanageBasket() async {
    try {
      state = OrphanageBasketStateLoading();
      List<OrphanageBasketEntity> data = await repository.getOrphanageBasket();
      print(data.first.basketProductId);
      state = OrphanageBasketStateSuccess(data);
    } catch (e) {
      print(e);
      state = OrphanageBasketStateError(e.toString());
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
      state = OrphanageProductStateError(e.toString());
    }
  }

  Future donate(DonateRequestDTO dto) async {
    try {
      state = OrphanageStateLoading();
      await repository.donate(dto);
      getOrphanageBasket();
    } catch (e) {
      state = OrphanageBasketStateError(e.toString());
    }
  }
}
