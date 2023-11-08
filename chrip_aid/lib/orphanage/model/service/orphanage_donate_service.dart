import 'package:chrip_aid/orphanage/model/entity/donate_entity.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/orphanage_basket_repository.dart';

final orphanageDonateServiceProvider =
StateNotifierProvider<OrphanageDonateService, OrphanageState>((ref) =>
    OrphanageDonateService(ref.watch(orphanageBasketRepositoryProvider)));

class OrphanageDonateService extends StateNotifier<OrphanageState> {
  final OrphanageBasketRepository repository;

  OrphanageDonateService(this.repository)
      : super(OrphanageDonateStateLoading()) {
    getOrphanageDonate();
  }

  Future getOrphanageDonate() async {
    try {
      state = OrphanageDonateStateLoading();
      List<DonateEntity> data = await repository.getOrphanageDonate('user');
      state = OrphanageDonateStateSuccess(data);
    } catch (e) {
      state = OrphanageDonateStateError(e.toString());
    }
  }


}
