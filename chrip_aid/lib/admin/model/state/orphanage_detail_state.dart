import 'package:chrip_aid/common/value_state/state/value_state.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import '../../../member/model/entity/orphanage_user_entity.dart';

class OrphanageDetailState extends ValueStateNotifier<OrphanageDetailEntity> {
  OrphanageDetailState() : super();

  factory OrphanageDetailState.loading() {
    final state = OrphanageDetailState();
    state.loading();
    return state;
  }

  factory OrphanageDetailState.success({required OrphanageDetailEntity data}) {
    final state = OrphanageDetailState();
    state.success(value: data);
    return state;
  }

  factory OrphanageDetailState.error({String? message}) {
    final state = OrphanageDetailState();
    state.error(message: message);
    return state;
  }
}

class OrphanageListState extends ValueStateNotifier<List<OrphanageUserEntity>> {
  OrphanageListState() : super();

  factory OrphanageListState.loading() {
    final state = OrphanageListState();
    state.loading();
    return state;
  }

  factory OrphanageListState.success({required List<OrphanageUserEntity> data}) {
    final state = OrphanageListState();
    state.success(value: data);
    return state;
  }

  factory OrphanageListState.error({String? message}) {
    final state = OrphanageListState();
    state.error(message: message);
    return state;
  }
}
