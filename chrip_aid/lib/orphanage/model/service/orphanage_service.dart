import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_entity.dart';
import 'package:chrip_aid/orphanage/model/repository/orphanage_repository.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageServiceProvider = StateNotifierProvider<OrphanageService, OrphanageState>(
    (ref) => OrphanageService(ref.watch(orphanageRepositoryProvider)));

class OrphanageService extends StateNotifier<OrphanageState> {
  final OrphanageRepository repository;

  OrphanageService(this.repository) : super(OrphanageStateNone()) {
    getOrphanageList();
//    getOrphanageDetail("1");
  }

  Future getOrphanageList() async {
    try {
      state = OrphanageStateLoading();
      List<OrphanageEntity> data = await repository.getOrphanageList();
      OrphanageState.list = data;
      state = OrphanageStateNone();
    } catch (e) {
      state = OrphanageStateError(e.toString());
    }
  }

  Future getOrphanageDetail(int orphanageId) async {
    try {
      state = OrphanageStateLoading();
      OrphanageDetailEntity data =
          await repository.getOrphanageDetail(orphanageId);
      state = OrphanageStateSuccess(data);
    } catch (e) {
      state = OrphanageStateError(e.toString());
    }
  }
}


