import 'package:json_annotation/json_annotation.dart';
part 'update_reservation_state_entity.g.dart';

@JsonSerializable()
class UpdateReservationStateEntity {
  @JsonKey(name: 'reservation_id')
  int reservationId;
  @JsonKey(name: 'state')
  String state;
  @JsonKey(name: 'message')
  String message;

  UpdateReservationStateEntity(
      {required this.reservationId,
      required this.state,
      required this.message});

  Map<String, dynamic> toJson()=>  _$UpdateReservationStateEntityToJson(this);
}
