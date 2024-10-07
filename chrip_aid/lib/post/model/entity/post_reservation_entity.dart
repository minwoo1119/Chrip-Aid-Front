import 'package:json_annotation/json_annotation.dart';

part 'post_reservation_entity.g.dart';

@JsonSerializable()
class PostReservationEntity {
  @JsonKey(name: 'reservation_id')
  final int reservationId;

  @JsonKey(name: 'visitor_name')
  final String visitorName;

  @JsonKey(name: 'visit_date')
  final String visitDate;

  @JsonKey(name: 'visitor_count')
  final int visitorCount;

  @JsonKey(name: 'orphanage_name')
  final String orphanageName;

  @JsonKey(name: 'state')
  final String state;

  @JsonKey(name: 'message')
  final String message;

  PostReservationEntity({
    required this.reservationId,
    required this.visitorName,
    required this.visitDate,
    required this.visitorCount,
    required this.orphanageName,
    required this.state,
    required this.message,
  });

  factory PostReservationEntity.fromJson(Map<String, dynamic> json) =>
      _$PostReservationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostReservationEntityToJson(this);
}
