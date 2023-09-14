import 'package:chrip_aid/common/local_storage/local_storage.dart';
import 'package:chrip_aid/orphanage/model/repository/orphanage_repository.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageVisitServiceProvider =
    StateNotifierProvider<OrphanageVisitService, OrphanageState>((ref) {
  final authRepository = ref.watch(orphanageRepositoryProvider);
  final storage = ref.watch(localStorageProvider);
  return OrphanageVisitService(authRepository, storage);
});

class OrphanageVisitService extends StateNotifier<OrphanageState> {
  final OrphanageRepository repository;
  final LocalStorage storage;

  OrphanageVisitService(this.repository, this.storage) : super(OrphanageVisitStateNone());

  Future post({
    required String date,
    required String purpose,
  }) async {
    state = OrphanageVisitStateLoading();

    // TODO : remove delay for test
    await Future.delayed(const Duration(seconds: 1));
    try {
      await repository.post(date, purpose);
    } catch (e) {
      state = OrphanageVisitStateError(e.toString());
    }
  }
}
