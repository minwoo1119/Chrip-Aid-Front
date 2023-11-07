import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';
import 'package:chrip_aid/reservation/model/service/reservation_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationViewModelProvider =
    ChangeNotifierProvider((ref) => ReservationViewModel(ref));

class ReservationViewModel extends ChangeNotifier {
  Ref ref;

  late OrphanageState state;
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
    listApprove = (state as ReservationStateSuccess)
        .data
        .where((item) => item.state == "APPROVED")
        .toList();
    listPending = (state as ReservationStateSuccess)
        .data
        .where((item) => item.state == "PENDING")
        .toList();
    listEnd = (state as ReservationStateSuccess)
        .data
        .where((item) => item.state == "REJECTED" || item.state == "COMPLETED")
        .toList();
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
    state = ref.read(reservationServiceProvider);
    ref.listen(reservationServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        divisionSortList();
        notifyListeners();
      }
    });
  }
}
