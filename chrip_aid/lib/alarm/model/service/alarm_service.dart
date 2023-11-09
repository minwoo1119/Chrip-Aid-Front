import 'package:chrip_aid/alarm/model/entity/alarm_entity.dart';
import 'package:chrip_aid/alarm/model/repository/alarm_repository.dart';
import 'package:chrip_aid/alarm/model/state/alarm_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alarmServiceProvider =
    StateNotifierProvider<AlarmService, AlarmState>((ref) {
  final repository = ref.watch(alarmRepositoryProvider);
  return AlarmService(repository);
});

class AlarmService extends StateNotifier<AlarmState> {
  final AlarmRepository repository;

  AlarmService(this.repository) : super(AlarmStateNone()) {
    getAlarms();
  }

  Future saveAlarm(AlarmEntity entity) async {
    await repository.saveAlarm(entity);
    getAlarms();
  }

  Future getAlarms() async {
    try {
      state = AlarmStateLoading();
      final data = await repository.getAlarms();
      state = AlarmStateSuccess(data);
    } catch (e) {
      state = AlarmStateError(e.toString());
    }
  }
}
