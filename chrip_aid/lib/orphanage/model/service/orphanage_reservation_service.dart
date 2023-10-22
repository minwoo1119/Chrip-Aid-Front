import 'package:chrip_aid/orphanage/model/entity/reservation_entity.dart';
import 'package:chrip_aid/orphanage/model/repository/orphanage_visit_reservation_repository.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageReservationServiceProvider =
StateNotifierProvider<OrphanageReservationService, OrphanageState>((ref) =>
    OrphanageReservationService(
        ref.watch(orphanageVisitReservationRepositoryProvider)));

class OrphanageReservationService extends StateNotifier<OrphanageState> {
  final OrphanageVisitReservationRepository repository;

  OrphanageReservationService(this.repository) : super(OrphanageReservationStateLoading()) {
    getOrphanageVisitReservation();
  }

  Future getOrphanageVisitReservation() async {
    try {
      state = OrphanageReservationStateLoading();
      List<OrphanageReservationEntity> data = await repository.getOrphanageVisitReservation();
      state = OrphanageReservationStateSuccess(data);
      print(data);
    } catch (e) {
      state = OrphanageReservationStateError(e.toString());
    }
  }
}
