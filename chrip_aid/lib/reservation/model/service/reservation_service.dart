import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/reservation/model/entity/orphanage_visit_entity.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';
import 'package:chrip_aid/reservation/model/repository/reservation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationServiceProvider = Provider((ref) {
  final repository = ref.watch(reservationRepositoryProvider);
  return ReservationService(repository);
});

class ReservationService {
  final ReservationRepository repository;

  ReservationService(this.repository);

  Future<ResponseEntity> postReservation(OrphanageVisitEntity entity) async {
    try {
      await repository.post(entity);
      return ResponseEntity.success(message: '예약에 성공하였습니다');
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity<List<ReservationEntity>>> getOrphanageReservation() async {
    try {
      final data = await repository.getOrphanageReservation('user');
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }
}
