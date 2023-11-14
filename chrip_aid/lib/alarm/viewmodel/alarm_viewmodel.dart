import 'package:chrip_aid/alarm/model/entity/alarm_entity.dart';
import 'package:chrip_aid/alarm/model/service/alarm_service.dart';
import 'package:chrip_aid/alarm/model/state/alarm_state.dart';
import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/utils/snack_bar_util.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final alarmViewmodelProvider =
    ChangeNotifierProvider((ref) => AlarmViewmodel(ref));

class AlarmViewmodel extends ChangeNotifier {
  Ref ref;

  List<AlarmEntity> get entities =>
      alarmState is SuccessState ? (alarmState as AlarmStateSuccess).data : [];

  late AuthService _service;

  AuthState get authState => _service.authState;
  late AlarmState alarmState;

  AlarmViewmodel(this.ref) {
    _service = ref.read(authServiceProvider);
    authState.addListener(() {
      if(authState.isSuccess) {
        ref.read(alarmServiceProvider.notifier).getAlarms();
      }
    });

    alarmState = ref.read(alarmServiceProvider);
    ref.listen(alarmServiceProvider, (previous, next) {
      if (previous != next) {
        alarmState = next;
        if (alarmState is ErrorState) {
          SnackBarUtil.showError((alarmState as ErrorState).message);
        }
        notifyListeners();
      }
    });
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
