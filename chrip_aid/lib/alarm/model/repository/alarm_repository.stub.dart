import 'package:chrip_aid/alarm/model/entity/alarm_entity.dart';
import 'package:chrip_aid/alarm/model/repository/alarm_repository.dart';
import 'package:chrip_aid/common/local_storage/local_storage.dart';

class AlarmRepositoryStub implements AlarmRepository {
  @override
  LocalStorage localStorage;

  AlarmRepositoryStub(this.localStorage);

  @override
  Future saveAlarm(AlarmEntity entity) async {}

  @override
  Future<List<AlarmEntity>> getAlarms() async {
    return [
      AlarmEntity(
        title: '감사합니다, 키다리 아저씨님!',
        body: "후원해주신 물건들이 아이들에게 무사히 도착했어요! 인증글을 확인해보세요!",
        time: DateTime.now(),
        type: AlarmType.post,
      ),
      AlarmEntity(
        title: '감사합니다, 키다리 아저씨님!',
        body: "후원해주신 물건들이 아이들에게 무사히 도착했어요! 인증글을 확인해보세요!",
        time: DateTime.now(),
        type: AlarmType.reservation,
      ),
    ];
  }
}
