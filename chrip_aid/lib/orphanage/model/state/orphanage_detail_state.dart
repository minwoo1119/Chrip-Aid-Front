import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_basket_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';

abstract class OrphanageState {}

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

class OrphanageBasketStateSuccess extends SuccessState<OrphanageBasketEntity> implements OrphanageState {
  OrphanageBasketStateSuccess(super.data);
}


class OrphanageBasketStateError extends ErrorState implements OrphanageState {
  OrphanageBasketStateError(super.message);
}

class OrphanageProductStateNone extends NoneState implements OrphanageState {}

class OrphanageProductStateLoading extends LoadingState implements OrphanageState {}

class OrphanageProductStateSuccess extends SuccessState<OrphanageDetailEntity> implements OrphanageState {
  OrphanageProductStateSuccess(super.data);
}

class OrphanageProductStateError extends ErrorState implements OrphanageState {
  OrphanageProductStateError(super.message);
}

class OrphanageVisitStateNone extends NoneState implements OrphanageState {}

class OrphanageVisitStateLoading extends LoadingState implements OrphanageState {}

class OrphanageVisitStateSuccess extends SuccessState<OrphanageDetailEntity> implements OrphanageState {
  OrphanageVisitStateSuccess(super.data);
}

class OrphanageVisitStateError extends ErrorState implements OrphanageState {
  OrphanageVisitStateError(super.message);
}
