import 'package:chrip_aid/reservation/model/entity/orphanage_visit_entity.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';
import 'package:chrip_aid/reservation/model/repository/reservation_repository.dart';
import 'package:chrip_aid/reservation/model/state/reservation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationServiceProvider = Provider((ref) {
  final repository = ref.watch(reservationRepositoryProvider);
  return ReservationService(repository);
});

class ReservationService {
  final ReservationRepository repository;

  final state = ReservationState();

  ReservationService(this.repository);

  Future postReservation(OrphanageVisitEntity entity) async {
    try {
      state.loading();
      await repository.post(entity);
      state.success(value: state.value, message: '예약에 성공하였습니다');
    } catch (e) {
      state.error(message: e.toString());
    }
  }

  Future getOrphanageReservation() async {
    try {
      state.loading();
      List<ReservationEntity> data =
          await repository.getOrphanageReservation('user');
      state.success(value: data);
    } catch (e) {
      state.error(message: e.toString());
    }
  }
}
