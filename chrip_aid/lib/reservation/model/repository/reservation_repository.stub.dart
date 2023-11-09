import 'package:chrip_aid/reservation/model/entity/orphanage_visit_entity.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';
import 'package:chrip_aid/reservation/model/repository/reservation_repository.dart';

class ReservationRepositoryStub implements ReservationRepository {
  @override
  Future<List<ReservationEntity>> getOrphanageReservation(String type) async {
    return visitOrphanageList;
  }

  @override
  Future<List<OrphanageReservationEntity>>
      getOrphanageVisitReservation(String type) async {
    return wantVisitOrphanageList;
  }

  List<ReservationEntity> visitOrphanageList = [
    ReservationEntity(
        orphanageName: "파주보육원",
        writeDate: "2023-10-05 03:34:22",
        visitDate: "2023-10-13 14:00:00",
        reason: "방문신청합니다",
        state: "APPROVED",
        rejectReason: "null"),
    ReservationEntity(
        orphanageName: "금오보육원",
        writeDate: "2023-10-05 03:34:22",
        visitDate: "2023-10-12 14:00:00",
        reason: "방문신청합니다",
        state: "PENDING",
        rejectReason: "null"),
    ReservationEntity(
        orphanageName: "OO보육원",
        writeDate: "2023-10-05 03:33:22",
        visitDate: "2023-10-11 14:00:00",
        reason: "방문신청합니다",
        state: "APPROVED",
        rejectReason: "null"),
    ReservationEntity(
        orphanageName: "옥계보육원",
        writeDate: "2023-10-05 03:32:22",
        visitDate: "2023-10-10 14:00:00",
        reason: "방문신청합니다",
        state: "PENDING",
        rejectReason: "null"),
    ReservationEntity(
        orphanageName: "아라보육원",
        writeDate: "2023-10-05 03:31:22",
        visitDate: "2023-10-08 14:00:00",
        reason: "방문신청합니다",
        state: "REJECTED",
        rejectReason: "그 날은 소풍 가는 날이라 방문하실 수 없어요ㅠㅠ"),
    ReservationEntity(
        orphanageName: "효돈보육원",
        writeDate: "2023-10-05 03:30:22",
        visitDate: "2023-10-06 14:00:00",
        reason: "방문신청합니다",
        state: "COMPLETED",
        rejectReason: "null"),
  ];

  List<OrphanageReservationEntity> wantVisitOrphanageList = [
    OrphanageReservationEntity(
        name: "홍길동",
        age: "20",
        sex: "남",
        region: "대구",
        phoneNumber: "010-0000-XXXX",
        writeDate: "2023-10-05 03:33:22",
        visitDate: "2023-10-11 14:00:00",
        reason: "방문신청합니다",
        state: "APPROVED",
        rejectReason: "null"),
    OrphanageReservationEntity(
        name: "이나라",
        age: "21",
        sex: "여",
        region: "제주",
        phoneNumber: "010-0000-XXXX",
        writeDate: "2023-10-05 03:33:22",
        visitDate: "2023-10-11 14:00:00",
        reason: "방문신청합니다",
        state: "REJECTED",
        rejectReason: "그 날은 소풍 가는 날 이라 방문하실 수 없어요ㅠㅠ"),
    OrphanageReservationEntity(
        name: "홍길돌",
        age: "21",
        sex: "여",
        region: "제주",
        phoneNumber: "010-0000-XXXX",
        writeDate: "2023-10-05 03:33:22",
        visitDate: "2023-10-11 14:00:00",
        reason: "방문신청합니다",
        state: "PENDING",
        rejectReason: "null"),
    OrphanageReservationEntity(
        name: "길돌홍",
        age: "21",
        sex: "여",
        region: "제주",
        phoneNumber: "010-0000-XXXX",
        writeDate: "2023-10-05 03:33:22",
        visitDate: "2023-10-11 14:00:00",
        reason: "방문신청합니다",
        state: "PENDING",
        rejectReason: "null"),
    OrphanageReservationEntity(
        name: "레오나르도",
        age: "21",
        sex: "남",
        region: "서울",
        phoneNumber: "010-0000-XXXX",
        writeDate: "2023-10-05 03:33:22",
        visitDate: "2023-10-11 14:00:00",
        reason: "방문신청합니다",
        state: "COMPLETED",
        rejectReason: "null"),
    OrphanageReservationEntity(
        name: "고길동",
        age: "41",
        sex: "남",
        region: "서울",
        phoneNumber: "010-0000-XXXX",
        writeDate: "2023-10-05 03:33:22",
        visitDate: "2023-10-11 14:00:00",
        reason: "방문신청합니다",
        state: "COMPLETED",
        rejectReason: "null"),
  ];

  @override
  Future post(OrphanageVisitEntity entity) async {
    return entity;
  }
}
