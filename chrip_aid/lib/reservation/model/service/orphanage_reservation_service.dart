import 'package:chrip_aid/reservation/model/entity/reservation_answer_request_dto.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';
import 'package:chrip_aid/reservation/model/repository/reservation_repository.dart';
import 'package:chrip_aid/reservation/model/state/reservation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageReservationServiceProvider = Provider((ref) {
  final repository = ref.watch(reservationRepositoryProvider);
  return OrphanageReservationService(repository);
});

class OrphanageReservationService {
  final ReservationRepository repository;

  final state = OrphanageReservationState();

  OrphanageReservationService(this.repository);

  Future getOrphanageVisitReservation() async {
    try {
      state.loading();
      List<OrphanageReservationEntity> data =
          await repository.getOrphanageVisitReservation('orphanage');
      state.success(value: data);
    } catch (e) {
      state.error(message: e.toString());
    }
  }

  Future answerToReservation(ReservationAnswerRequestDto dto) async {
    try {
      state.loading();
      await repository.answer(dto);
      getOrphanageVisitReservation();
    } catch (e) {
      state.error(message: e.toString());
    }
  }
}
