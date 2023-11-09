import 'package:chrip_aid/reservation/model/entity/orphanage_visit_entity.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';
import 'package:chrip_aid/reservation/model/repository/reservation_repository.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationServiceProvider =
    StateNotifierProvider<ReservationService, OrphanageState>((ref) =>
        ReservationService(
            ref.watch(reservationRepositoryProvider)));

class ReservationService extends StateNotifier<OrphanageState> {
  final ReservationRepository repository;

  ReservationService(this.repository) : super(ReservationStateLoading()) {
    getOrphanageReservation();
  }

  Future postReservation(OrphanageVisitEntity entity) async {
    try {
      await repository.post(entity);
    } catch (e) {
      state = ReservationStateError(e.toString());
    }
  }

  Future getOrphanageReservation() async {
    try {
      state = ReservationStateLoading();
      List<ReservationEntity> data = await repository.getOrphanageReservation('user');
      state = ReservationStateSuccess(data);
      print(data);
    } catch (e) {
      state = ReservationStateError(e.toString());
    }
  }
}
