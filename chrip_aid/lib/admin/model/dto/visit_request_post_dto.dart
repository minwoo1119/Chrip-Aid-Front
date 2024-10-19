import 'package:json_annotation/json_annotation.dart';
import '../../../post/model/entity/post_reservation_entity.dart';

part 'visit_request_post_dto.g.dart';

@JsonSerializable()
class VisitRequestPostDto {
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

  VisitRequestPostDto({
    required this.reservationId,
    required this.writeDate,
    required this.visitDate,
    required this.reason,
    required this.state,
    this.rejectReason,
  });

  factory VisitRequestPostDto.fromJson(Map<String, dynamic> json) =>
      _$VisitRequestPostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VisitRequestPostDtoToJson(this);

  // DTO에서 Entity로 변환
  PostReservationEntity toEntity() {
    return PostReservationEntity(
      reservationId: reservationId,
      writeDate: writeDate,
      visitDate: visitDate,
      reason: reason,
      state: state,
      rejectReason: rejectReason,
    );
  }
}
