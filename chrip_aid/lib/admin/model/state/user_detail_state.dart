import 'package:chrip_aid/common/value_state/state/value_state.dart';
import 'package:chrip_aid/member/model/entity/user_detail_entity.dart';

class UserDetailState extends ValueStateNotifier<UserDetailEntity> {
  UserDetailState() : super();

  factory UserDetailState.loading() {
    final state = UserDetailState();
    state.loading();
    return state;
  }

  factory UserDetailState.success({required UserDetailEntity data}) {
    final state = UserDetailState();
    state.success(value: data);
    return state;
  }

  factory UserDetailState.error({String? message}) {
    final state = UserDetailState();
    state.error(message: message);
    return state;
  }
}

class UserListState extends ValueStateNotifier<List<UserDetailEntity>> {
  UserListState() : super();

  factory UserListState.loading() {
    final state = UserListState();
    state.loading();
    return state;
  }

  factory UserListState.success({required List<UserDetailEntity> data}) {
    final state = UserListState();
    state.success(value: data);
    return state;
  }

  factory UserListState.error({String? message}) {
    final state = UserListState();
    state.error(message: message);
    return state;
  }
}


