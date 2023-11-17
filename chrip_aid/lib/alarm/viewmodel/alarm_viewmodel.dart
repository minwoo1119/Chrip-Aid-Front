import 'package:chrip_aid/alarm/model/entity/alarm_entity.dart';
import 'package:chrip_aid/alarm/model/service/alarm_service.dart';
import 'package:chrip_aid/alarm/model/state/alarm_state.dart';
import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final alarmViewmodelProvider = Provider((ref) => AlarmViewmodel(ref));

class AlarmViewmodel {
  Ref ref;

  late final AlarmService _alarmService;

  final AlarmState _alarmState = AlarmState();

  AlarmState get alarmState => _alarmState;

  AlarmViewmodel(this.ref) {
    _alarmService = ref.read(alarmServiceProvider);
  }

  void getAlarms() => _alarmState.withResponse(_alarmService.getAlarms());

  void _navigateToReservationScreen(BuildContext context) {
    context.pushNamed(ReservationScreen.routeName);
  }

  void _navigateToPostDetailScreen(BuildContext context) {
    context.pushNamed(PostScreen.routeName);
  }

  void navigateToScreen(BuildContext context, AlarmType type) {
    switch (type) {
      case AlarmType.post:
        return _navigateToPostDetailScreen(context);
      case AlarmType.reservation:
        return _navigateToReservationScreen(context);
    }
  }
}
