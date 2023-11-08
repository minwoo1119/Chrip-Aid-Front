import 'package:json_annotation/json_annotation.dart';
part 'reservation_entity.g.dart';

@JsonSerializable()
class ReservationEntity {
  @JsonKey(name: 'orphanage_name')
  final String orphanageName;
  @JsonKey(name: 'write_date')
  final String writeDate;
  @JsonKey(name: 'visit_date')
  final String visitDate;
  @JsonKey(name: 'reason')
  final String reason;
  @JsonKey(name: 'state')
  final String state;
  @JsonKey(name: 'reject_reason')
  final String rejectReason;


  ReservationEntity({
    required this.orphanageName,
    required this.writeDate,
    required this.visitDate,
    required this.reason,
    required this.state,
    required this.rejectReason,
  });

  factory ReservationEntity.fromJson(Map<String, dynamic> json) =>
      _$ReservationEntityFromJson(json);
}

// 보육원 계정일 경우
@JsonSerializable()
class OrphanageReservationEntity {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'age')
  final String age;
  @JsonKey(name: 'sex')
  final String sex;
  @JsonKey(name: 'region')
  final String region;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'write_date')
  final String writeDate;
  @JsonKey(name: 'visit_date')
  final String visitDate;
  @JsonKey(name: 'reason')
  final String reason;
  @JsonKey(name: 'state')
  final String state;
  @JsonKey(name: 'reject_reason')
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

  factory OrphanageReservationEntity.fromJson(Map<String, dynamic> json) =>
      _$OrphanageReservationEntityFromJson(json);
}
