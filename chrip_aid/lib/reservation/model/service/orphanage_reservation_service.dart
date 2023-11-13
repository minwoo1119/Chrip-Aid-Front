import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';
import 'package:chrip_aid/reservation/model/repository/reservation_repository.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageReservationServiceProvider =
StateNotifierProvider<OrphanageReservationService, OrphanageState>((ref) =>
    OrphanageReservationService(
        ref.watch(reservationRepositoryProvider)));

class OrphanageReservationService extends StateNotifier<OrphanageState> {
  final ReservationRepository repository;

  OrphanageReservationService(this.repository) : super(OrphanageReservationStateLoading()) {
    getOrphanageVisitReservation();
  }

  Future getOrphanageVisitReservation() async {
    try {
      state = OrphanageReservationStateLoading();
      List<OrphanageReservationEntity> data = await repository.getOrphanageVisitReservation('orphanage');
      state = OrphanageReservationStateSuccess(data);
      print("[Chrip Aid] ${data}");
    } catch (e) {
      state = OrphanageReservationStateError(e.toString());
    }
  }
}
