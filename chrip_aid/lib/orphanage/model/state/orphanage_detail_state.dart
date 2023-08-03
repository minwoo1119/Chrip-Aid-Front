import 'package:chrip_aid/auth/model/entity/user_entity.dart';
import 'package:chrip_aid/common/state/state.dart';
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
