import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';
import 'package:chrip_aid/reservation/model/service/reservation_service.dart';
import 'package:chrip_aid/reservation/model/state/reservation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationViewModelProvider =
    ChangeNotifierProvider((ref) => ReservationViewModel(ref));

class ReservationViewModel extends ChangeNotifier {
  Ref ref;

  late final ReservationService _reservationService;

  final ReservationState reservationState = ReservationState();
  late TabController tabController;

  String? selectedTabIndex;
  List<ReservationEntity> listAll = [];
  List<ReservationEntity> listEnd = [];
  List<ReservationEntity> listPending = [];
  List<ReservationEntity> listApprove = [];

  List<List<ReservationEntity>> get list => [
    listAll, listApprove, listEnd, listPending,
  ];


  ReservationViewModel(this.ref) {
    _reservationService = ref.read(reservationServiceProvider);
    reservationState.addListener(() {
      if (reservationState.isSuccess) {
        divisionSortList();
      }
    });
  }

  void getInfo(TickerProvider vsync) {
    tabController = TabController(length: list.length, vsync: vsync);
    reservationState.withResponse(
      _reservationService.getOrphanageReservation(),
    );
  }

  void divisionSortList() {
    listApprove =
        reservationState.value?.where((item) => item.state == "APPROVED").toList() ?? [];
    listPending =
        reservationState.value?.where((item) => item.state == "PENDING").toList() ?? [];
    listEnd = reservationState.value
            ?.where(
                (item) => item.state == "REJECTED" || item.state == "COMPLETED")
            .toList() ??
        [];

    listAll.clear();
    listAll += listApprove;
    listAll += listPending;
    listAll += listEnd;
  }

  void changeSelectedTab(int index) {
    if (index == 0) {
      selectedTabIndex = null;
    } else if (index == 1) {
      selectedTabIndex = "APPROVED";
    } else if (index == 2) {
      selectedTabIndex = "PENDING";
    } else if (index == 3) {
      selectedTabIndex = "ENDED";
    }
  }
}
