import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_answer_request_dto.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';
import 'package:chrip_aid/reservation/model/repository/reservation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageReservationServiceProvider = Provider((ref) {
  final repository = ref.watch(reservationRepositoryProvider);
  return OrphanageReservationService(repository);
});

class OrphanageReservationService {
  final ReservationRepository repository;

  OrphanageReservationService(this.repository);

  Future<ResponseEntity<List<OrphanageReservationEntity>>>
      getOrphanageVisitReservation() async {
    try {
      final data = await repository.getOrphanageVisitReservation('orphanage');
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity<List<OrphanageReservationEntity>>> answerToReservation(
    ReservationAnswerRequestDto dto,
  ) async {
    try {
      await repository.answer(dto);
      return getOrphanageVisitReservation();
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }
}
