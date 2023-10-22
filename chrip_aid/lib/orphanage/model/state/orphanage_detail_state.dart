import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_entity.dart';

abstract class OrphanageState {
  static List<OrphanageEntity> list = [];
}

class OrphanageStateNone extends NoneState implements OrphanageState {}

class OrphanageStateLoading extends LoadingState implements OrphanageState {}

class OrphanageStateSuccess extends SuccessState<OrphanageDetailEntity> implements OrphanageState {
  OrphanageStateSuccess(super.data);
}

class OrphanageStateError extends ErrorState implements OrphanageState {
  OrphanageStateError(super.message);
}

//장바구니

class OrphanageBasketStateNone extends NoneState implements OrphanageState {}

class OrphanageBasketStateLoading extends LoadingState implements OrphanageState {}

class OrphanageBasketStateSuccess extends SuccessState<List<OrphanageBasketEntity>> implements OrphanageState {
  OrphanageBasketStateSuccess(super.data);
}

class OrphanageBasketStateError extends ErrorState implements OrphanageState {
  OrphanageBasketStateError(super.message);
}
class OrphanageDonateStateNone extends NoneState implements OrphanageState {}

class OrphanageDonateStateLoading extends LoadingState implements OrphanageState {}

class OrphanageDonateStateSuccess extends SuccessState<List<DonateEntity>> implements OrphanageState {
  OrphanageDonateStateSuccess(super.data);
}
class OrphanageDonateStateError extends ErrorState implements OrphanageState {
  OrphanageDonateStateError(super.message);
}

class OrphanagePostStateNone extends NoneState implements OrphanageState {}

class OrphanagePostStateLoading extends LoadingState implements OrphanageState {}

class OrphanagePostStateSuccess extends SuccessState<List<GetPostsEntity>> implements OrphanageState {
  OrphanagePostStateSuccess(super.data);
}
class OrphanagePostStateError extends ErrorState implements OrphanageState {
  OrphanagePostStateError(super.message);
}


class OrphanageProductStateNone extends NoneState implements OrphanageState {}

class OrphanageProductStateLoading extends LoadingState implements OrphanageState {}

class OrphanageProductStateSuccess extends SuccessState<OrphanageDetailEntity> implements OrphanageState {
  OrphanageProductStateSuccess(super.data);
}

class OrphanageProductStateError extends ErrorState implements OrphanageState {
  OrphanageProductStateError(super.message);
}

class ReservationStateNone extends NoneState implements OrphanageState {}

class ReservationStateLoading extends LoadingState implements OrphanageState {}

class ReservationStateSuccess extends SuccessState<List<ReservationEntity>> implements OrphanageState {
  ReservationStateSuccess(super.data);
}

class ReservationStateError extends ErrorState implements OrphanageState {
  ReservationStateError(super.message);
}

// class OrphanageReservationStateSuccess<T> extends SuccessState<List<T>> implements OrphanageState {
//   OrphanageReservationStateSuccess(List<T> data) : super(data);
// }

// OrphanageReservationStateSuccess<ReservationEntity> reservationState = OrphanageReservationStateSuccess(reservationData);
// OrphanageReservationStateSuccess<OrphanageReservationEntity> orphanageState = OrphanageReservationStateSuccess(orphanageData);

class OrphanageReservationStateNone extends NoneState implements OrphanageState {}

class OrphanageReservationStateLoading extends LoadingState implements OrphanageState {}

class OrphanageReservationStateSuccess extends SuccessState<List<OrphanageReservationEntity>> implements OrphanageState {
  OrphanageReservationStateSuccess(super.data);
}

class OrphanageReservationStateError extends ErrorState implements OrphanageState {
  OrphanageReservationStateError(super.message);
}