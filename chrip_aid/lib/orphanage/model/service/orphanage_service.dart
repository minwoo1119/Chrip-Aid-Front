import 'package:chrip_aid/orphanage/model/entity/orphanage_entity.dart';
import 'package:chrip_aid/orphanage/model/repository/orphanage_repository.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageServiceProvider = Provider((ref) {
  final repository = ref.watch(orphanageRepositoryProvider);
  return OrphanageService(repository);
});

class OrphanageService {
  final OrphanageRepository repository;

  final OrphanageListState orphanageListState = OrphanageListState();
  final OrphanageDetailState orphanageDetailState = OrphanageDetailState();

  OrphanageService(this.repository);

  Future getOrphanageList() async {
    try {
      orphanageListState.loading();
      List<OrphanageEntity> data = await repository.getOrphanageList();
      orphanageListState.success(value: data);
    } catch (e) {
      orphanageListState.error(message: e.toString());
    }
  }

  Future getOrphanageDetail(int orphanageId) async {
    try {
      orphanageDetailState.loading();
      final data = await repository.getOrphanageDetail(orphanageId);
      orphanageDetailState.success(value: data);
    } catch (e) {
      orphanageDetailState.error(message: e.toString());
    }
  }
}
