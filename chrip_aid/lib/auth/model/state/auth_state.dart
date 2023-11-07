import 'package:chrip_aid/common/state/state.dart';

abstract class AuthState {}

class AuthStateNone extends NoneState implements AuthState {}

class AuthStateLoading extends LoadingState implements AuthState {}

class AuthStateSuccess extends SuccessState<bool> implements AuthState {
  AuthStateSuccess(super.data);
}

class AuthStateError extends ErrorState implements AuthState {
  AuthStateError(super.message);
}
