import 'package:chrip_aid/common/state/state.dart';

abstract class UserInfoState {}

class UserInfoStateNone extends NoneState implements UserInfoState {}

class UserInfoStateLoading extends LoadingState implements UserInfoState {}

class UserInfoStateSuccess extends SuccessState<bool> implements UserInfoState {
  UserInfoStateSuccess(super.data);
}

class UserInfoStateError extends ErrorState implements UserInfoState {
  UserInfoStateError(super.message);
}
