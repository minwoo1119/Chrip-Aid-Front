import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';

abstract class OrphanageManagementState {
  static List<ProductEntity> productList = [];
}

class OrphanageManagementStateNone extends NoneState
    implements OrphanageManagementState {}

class OrphanageManagementStateLoading extends LoadingState
    implements OrphanageManagementState {}

class OrphanageManagementStateSuccess
    extends SuccessState<OrphanageDetailEntity>
    implements OrphanageManagementState {
  OrphanageManagementStateSuccess(super.data);
}

class OrphanageManagementStateError extends ErrorState
    implements OrphanageManagementState {
  OrphanageManagementStateError(super.message);
}
