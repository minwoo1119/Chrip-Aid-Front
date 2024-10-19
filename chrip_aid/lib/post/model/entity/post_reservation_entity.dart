import 'package:json_annotation/json_annotation.dart';

part 'post_reservation_entity.g.dart';

@JsonSerializable()
class PostReservationEntity {
  @JsonKey(name: 'reservationId')
  final int reservationId;

  @JsonKey(name: 'writeDate')
  final String writeDate;

  @JsonKey(name: 'visitDate')
  final String visitDate;

  @JsonKey(name: 'reason')
  final String reason;

  @JsonKey(name: 'state')
  final String state;

  @JsonKey(name: 'rejectReason')
  final String? rejectReason;

  PostReservationEntity({
    required this.reservationId,
    required this.writeDate,
    required this.visitDate,
    required this.reason,
    required this.state,
    this.rejectReason,
  });

  factory PostReservationEntity.fromJson(Map<String, dynamic> json) =>
      _$PostReservationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostReservationEntityToJson(this);
}
