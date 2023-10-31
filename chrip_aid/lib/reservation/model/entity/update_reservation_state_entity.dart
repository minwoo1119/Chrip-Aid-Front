class UpdateReservationStateEntity {
  int reservationId;
  String state;
  String message;

  UpdateReservationStateEntity(
      {required this.reservationId,
      required this.state,
      required this.message});
}
