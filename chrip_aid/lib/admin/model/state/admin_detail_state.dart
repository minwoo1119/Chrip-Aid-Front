import 'package:chrip_aid/common/value_state/state/value_state.dart';
import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/donate_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_basket_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_entity.dart';

import '../../../chatting/model/entity/chat_room_entity.dart';

class OrphanageListState
    extends ValueStateNotifier<List<OrphanageMemberEntity>> {
  OrphanageListState() : super();

  factory OrphanageListState.loading() {
    final state = OrphanageListState();
    state.loading();
    return state;
  }

  factory OrphanageListState.success(
      {required List<OrphanageMemberEntity> data}) {
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

class OrphanageDetailState extends ValueStateNotifier<OrphanageMemberEntity> {
  OrphanageDetailState() : super();

  factory OrphanageDetailState.loading() {
    final state = OrphanageDetailState();
    state.loading();
    return state;
  }

  factory OrphanageDetailState.success({required OrphanageMemberEntity data}) {
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

class OrphanageBasketState
    extends ValueStateNotifier<List<OrphanageBasketEntity>> {}

class OrphanageDonateState extends ValueStateNotifier<List<DonateEntity>> {}
