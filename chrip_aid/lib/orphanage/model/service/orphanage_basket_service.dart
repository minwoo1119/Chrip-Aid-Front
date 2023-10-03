import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/orphanage_basket_entity.dart';
import '../repository/orphanage_basket_repository.dart';

final orphanageBasketServiceProvider = StateNotifierProvider<OrphanageBasketService, OrphanageState>(
        (ref) => OrphanageBasketService(ref.watch(orphanageBasketRepositoryProvider)));

class OrphanageBasketService extends StateNotifier<OrphanageState> {
  final OrphanageBasketRepository repository;

  OrphanageBasketService(this.repository) : super(OrphanageBasketStateLoading()) {
    getOrphanageBasket("1");
  }

  Future getOrphanageBasket(String orphanageId) async {
    try {
      state = OrphanageBasketStateLoading();
      OrphanageBasketEntity data =
      await repository.getOrphanageBasket(orphanageId);
      state = OrphanageBasketStateSuccess(data);
    } catch (e) {
      state = OrphanageBasketStateError(e.toString());
    }
  }
}
