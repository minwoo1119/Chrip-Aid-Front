import 'package:chrip_aid/orphanage/model/entity/donate_entity.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/orphanage_basket_repository.dart';

final orphanageDonateServiceProvider = Provider((ref) {
  final repository = ref.watch(orphanageBasketRepositoryProvider);
  return OrphanageDonateService(repository);
});

class OrphanageDonateService {
  final OrphanageBasketRepository repository;

  final donateState = OrphanageDonateState();

  OrphanageDonateService(this.repository);

  Future getOrphanageDonate() async {
    try {
      donateState.loading();
      List<DonateEntity> data = await repository.getOrphanageDonate('user');
      donateState.success(value: data);
    } catch (e) {
      donateState.error(message: e.toString());
    }
  }
}
