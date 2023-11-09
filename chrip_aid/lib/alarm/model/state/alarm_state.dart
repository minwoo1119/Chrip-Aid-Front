import 'package:chrip_aid/alarm/model/entity/alarm_entity.dart';
import 'package:chrip_aid/common/state/state.dart';

abstract class AlarmState {}

class AlarmStateNone extends NoneState implements AlarmState {}

class AlarmStateLoading extends LoadingState implements AlarmState {}

class AlarmStateSuccess extends SuccessState<List<AlarmEntity>> implements AlarmState {
  AlarmStateSuccess(super.data);
}

class AlarmStateError extends ErrorState implements AlarmState {
  AlarmStateError(super.message);
}
