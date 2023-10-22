import 'package:chrip_aid/orphanage/model/entity/reservation_entity.dart';
import 'package:chrip_aid/orphanage/model/repository/orphanage_visit_reservation_repository.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationServiceProvider =
    StateNotifierProvider<ReservationService, OrphanageState>((ref) =>
        ReservationService(
            ref.watch(orphanageVisitReservationRepositoryProvider)));

class ReservationService extends StateNotifier<OrphanageState> {
  final OrphanageVisitReservationRepository repository;

  ReservationService(this.repository) : super(ReservationStateLoading()) {
    getOrphanageReservation();
  }

  Future postReservation({
    required String date,
    required String purpose,
  }) async {
    try {
      await repository.post(date, purpose);
    } catch (e) {
      state = ReservationStateError(e.toString());
    }
  }

  Future getOrphanageReservation() async {
    try {
      state = ReservationStateLoading();
      List<ReservationEntity> data = await repository.getOrphanageReservation();
      state = ReservationStateSuccess(data);
      print(data);
    } catch (e) {
      state = ReservationStateError(e.toString());
    }
  }
}
