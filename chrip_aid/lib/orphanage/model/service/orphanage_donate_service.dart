import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/donate_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/orphanage_basket_repository.dart';

final orphanageDonateServiceProvider = Provider((ref) {
  final repository = ref.watch(orphanageBasketRepositoryProvider);
  return OrphanageDonateService(repository);
});

class OrphanageDonateService {
  final OrphanageBasketRepository repository;

  OrphanageDonateService(this.repository);

  Future<ResponseEntity<List<DonateEntity>>> getOrphanageDonate() async {
    try {
      final data = await repository.getOrphanageDonate('user');
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }
}
