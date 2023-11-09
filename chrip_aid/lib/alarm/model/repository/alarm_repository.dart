import 'dart:convert' as convert;

import 'package:chrip_aid/alarm/model/entity/alarm_entity.dart';
import 'package:chrip_aid/common/local_storage/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alarmRepositoryProvider = Provider((ref) {
  final localStorage = ref.watch(localStorageProvider);
  return AlarmRepository(localStorage);
});

class AlarmRepository {
  LocalStorage localStorage;
  final String _key = 'alarm';

  AlarmRepository(this.localStorage);

  Future saveAlarm(AlarmEntity entity) async {
    final temp = await localStorage.read(key: _key);
    final List<dynamic> json = convert.json.decode(temp ?? "[]");
    json.add(entity.toJson());
    await localStorage.write(key: "alarm", value: convert.json.encode(json));
  }

  Future<List<AlarmEntity>> getAlarms() async {
    final temp = await localStorage.read(key: _key);
    final List<dynamic> json = convert.json.decode(temp ?? "[]");
    return json.map((e) => AlarmEntity.fromJson(e)).toList();
  }
}