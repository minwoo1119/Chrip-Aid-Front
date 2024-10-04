import 'package:chrip_aid/common/value_state/state/value_state.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_entity.dart';

import '../../../member/model/entity/orphanage_member_entity.dart';

class UserOrphanageDetailState extends ValueStateNotifier<OrphanageDetailEntity> {
  UserOrphanageDetailState() : super();

  factory UserOrphanageDetailState.loading() {
    final state = UserOrphanageDetailState();
    state.loading();
    return state;
  }

  factory UserOrphanageDetailState.success({required OrphanageDetailEntity data}) {
    final state = UserOrphanageDetailState();
    state.success(value: data);
    return state;
  }

  factory UserOrphanageDetailState.error({String? message}) {
    final state = UserOrphanageDetailState();
    state.error(message: message);
    return state;
  }
}

class UserOrphanageListState extends ValueStateNotifier<List<OrphanageMemberEntity>> {
  UserOrphanageListState() : super();

  factory UserOrphanageListState.loading() {
    final state = UserOrphanageListState();
    state.loading();
    return state;
  }

  factory UserOrphanageListState.success({required List<OrphanageMemberEntity> data}) {
    final state = UserOrphanageListState();
    state.success(value: data);
    return state;
  }

  factory UserOrphanageListState.error({String? message}) {
    final state = UserOrphanageListState();
    state.error(message: message);
    return state;
  }
}
