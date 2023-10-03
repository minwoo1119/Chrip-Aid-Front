import 'package:chrip_aid/orphanage/model/repository/orphanage_repository.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageProductServiceProvider = StateNotifierProvider<OrphanageProductService, OrphanageState>(
        (ref) => OrphanageProductService(ref.watch(orphanageRepositoryProvider)));

class OrphanageProductService extends StateNotifier<OrphanageState> {
  final OrphanageRepository repository;


  OrphanageProductService(this.repository) : super(OrphanageProductStateNone());

  Future add({
    required String requestId,
    required int count,
  }) async {
    state = OrphanageProductStateLoading();
    // TODO : remove delay for test
    await Future.delayed(const Duration(seconds: 1));

    try {
      repository.addItem(requestId, count);
    } catch (e) {
      state = OrphanageProductStateError(e.toString());
    }
  }

  Future checkCart() async {
    repository.checkCart();
  }
}
