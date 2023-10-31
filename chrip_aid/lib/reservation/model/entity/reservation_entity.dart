class ReservationEntity {
  final String orphanageName;
  final String writeDate;
  final String visitDate;
  final String reason;
  final String state;
  final String rejectReason;


  ReservationEntity({
    required this.orphanageName,
    required this.writeDate,
    required this.visitDate,
    required this.reason,
    required this.state,
    required this.rejectReason,
  });
}

// 보육원 계정일 경우
class OrphanageReservationEntity {
  final String name;
  final String age;
  final String sex;
  final String region;
  final String phoneNumber;
  final String writeDate;
  final String visitDate;
  final String reason;
  final String state;
  final String rejectReason;

  OrphanageReservationEntity({
    required this.name,
    required this.age,
    required this.sex,
    required this.region,
    required this.phoneNumber,
    required this.writeDate,
    required this.visitDate,
    required this.reason,
    required this.state,
    required this.rejectReason,
  });
}
