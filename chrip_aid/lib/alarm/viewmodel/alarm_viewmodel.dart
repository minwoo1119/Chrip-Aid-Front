import 'package:chrip_aid/alarm/model/entity/alarm_entity.dart';
import 'package:chrip_aid/alarm/model/service/alarm_service.dart';
import 'package:chrip_aid/alarm/model/state/alarm_state.dart';
import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final alarmViewmodelProvider =
    ChangeNotifierProvider((ref) => AlarmViewmodel(ref));

class AlarmViewmodel extends ChangeNotifier {
  Ref ref;

  late final AlarmService _alarmService;

  AlarmState get alarmState => _alarmService.state;

  List<AlarmEntity> get entities => alarmState.value ?? [];

  late AuthService _authService;

  AuthState get authState => _authService.authState;

  AlarmViewmodel(this.ref) {
    _authService = ref.read(authServiceProvider);
    authState.addListener(() {
      if (authState.isSuccess) {
        _alarmService.getAlarms();
      }
    });

    _alarmService = ref.read(alarmServiceProvider);
    alarmState.addListener(notifyListeners);
  }

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
