import 'package:chrip_aid/reservation/model/entity/reservation_answer_request_dto.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';
import 'package:chrip_aid/reservation/model/service/orphanage_reservation_service.dart';
import 'package:chrip_aid/reservation/model/state/reservation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageReservationViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageReservationViewModel(ref));

class OrphanageReservationViewModel extends ChangeNotifier {
  Ref ref;

  late final OrphanageReservationService _orphanageReservationService;

  OrphanageReservationState get state => _orphanageReservationService.state;
  String? selectedTabIndex;
  List<OrphanageReservationEntity> listAll = [];
  List<OrphanageReservationEntity> listEnd = [];
  List<OrphanageReservationEntity> listPending = [];
  List<OrphanageReservationEntity> listApprove = [];

  List<OrphanageReservationEntity> get filteredEntity {
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

  OrphanageReservationViewModel(this.ref) {
    _orphanageReservationService =
        ref.read(orphanageReservationServiceProvider);
    state.addListener(() {
      if (state.isSuccess) {
        divisionSortList();
      }
      notifyListeners();
    });
  }

  void answerToReservation(int reservationId, String state) {
    _orphanageReservationService.answerToReservation(
      ReservationAnswerRequestDto(
        reservationId: reservationId,
        state: state,
        message: state == "REJECTED" ? "그 날은 소풍 가는 날이라 방문하실 수 없어요..." : "",
      ),
    );
  }

// late TabController tabController;
//
// void initTabController(int length, TickerProvider vsync) {
//   tabController = TabController(length: length, vsync: vsync);
//   tabController.addListener(() {
//     changeSelectedTab(tabController.index);
//     notifyListeners();
//   });
// }
}
