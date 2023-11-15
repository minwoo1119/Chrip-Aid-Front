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

  ReservationState get state => _reservationService.state;

  String? selectedTabIndex;
  List<ReservationEntity> listAll = [];
  List<ReservationEntity> listEnd = [];
  List<ReservationEntity> listPending = [];
  List<ReservationEntity> listApprove = [];

  List<ReservationEntity> get filteredEntity {
    return selectedTabIndex == null
        ? listAll
        : selectedTabIndex == "APPROVED"
            ? listApprove
            : selectedTabIndex == "PENDING"
                ? listPending
                : listEnd;
  }

  void divisionSortList() {
    listApprove =
        state.value?.where((item) => item.state == "APPROVED").toList() ?? [];
    listPending =
        state.value?.where((item) => item.state == "PENDING").toList() ?? [];
    listEnd = state.value
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

  ReservationViewModel(this.ref) {
    _reservationService = ref.read(reservationServiceProvider);
    state.addListener(() {
      if (state.isSuccess) {
        divisionSortList();
      }
      notifyListeners();
    });
  }
}
