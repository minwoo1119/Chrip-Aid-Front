import 'package:chrip_aid/alarm/model/entity/alarm_entity.dart';
import 'package:chrip_aid/alarm/model/repository/alarm_repository.dart';
import 'package:chrip_aid/alarm/model/state/alarm_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alarmServiceProvider = Provider((ref) {
  final repository = ref.watch(alarmRepositoryProvider);
  return AlarmService(repository);
});

class AlarmService {
  final AlarmRepository repository;

  final AlarmState state = AlarmState();

  AlarmService(this.repository) {
    getAlarms();
  }

  Future saveAlarm(AlarmEntity entity) async {
    await repository.saveAlarm(entity);
    getAlarms();
  }

  Future getAlarms() async {
    try {
      state.loading();
      final data = await repository.getAlarms();
      state.success(value: data);
    } catch (e) {
      state.error(message: e.toString());
    }
  }
}
