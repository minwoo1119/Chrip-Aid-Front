import 'package:json_annotation/json_annotation.dart';

part 'reservation_answer_request_dto.g.dart';

@JsonSerializable()
class ReservationAnswerRequestDto {
  @JsonKey(name: "reservation_id")
  int reservationId;
  @JsonKey(name: "state")
  String state;
  @JsonKey(name: "message")
  String message;

  ReservationAnswerRequestDto({
    required this.reservationId,
    required this.state,
    required this.message,
  });

  Map<String, dynamic> toJson()=>  _$ReservationAnswerRequestDtoToJson(this);
}
