import 'package:chrip_aid/alarm/model/entity/alarm_entity.dart';
import 'package:chrip_aid/alarm/model/repository/alarm_repository.dart';
import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alarmServiceProvider = Provider((ref) {
  final repository = ref.watch(alarmRepositoryProvider);
  return AlarmService(repository);
});

class AlarmService {
  final AlarmRepository repository;

  AlarmService(this.repository);

  Future<ResponseEntity> saveAlarm(AlarmEntity entity) async {
    try {
      await repository.saveAlarm(entity);
      return ResponseEntity.success();
    } catch (e) {
      return ResponseEntity.error(message: "알람 정보 저장에 실패하였습니다.");
    }
  }

  Future<ResponseEntity<List<AlarmEntity>>> getAlarms() async {
    try {
      final data = await repository.getAlarms();
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: "알람 정보를 불러오는데 실패하였습니다.");
    }
  }
}
