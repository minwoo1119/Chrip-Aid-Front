import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_answer_request_dto.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';
import 'package:chrip_aid/reservation/model/service/orphanage_reservation_service.dart';
import 'package:chrip_aid/reservation/model/state/reservation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageReservationViewModelProvider =
    Provider((ref) => OrphanageReservationViewModel(ref));

class OrphanageReservationViewModel {
  Ref ref;

  late final OrphanageReservationService _orphanageReservationService;

  late TabController tabController;

  final OrphanageReservationState reservationState =
      OrphanageReservationState();
  String? selectedTabIndex;
  List<OrphanageReservationEntity> listAll = [];
  List<OrphanageReservationEntity> listEnd = [];
  List<OrphanageReservationEntity> listPending = [];
  List<OrphanageReservationEntity> listApprove = [];

  List<List<OrphanageReservationEntity>> get list => [
    listAll, listApprove, listPending, listEnd,
  ];

  void divisionSortList() {
    listApprove = reservationState.value
            ?.where((item) => item.state == "APPROVED")
            .toList() ??
        [];
    listPending = reservationState.value
            ?.where((item) => item.state == "PENDING")
            .toList() ??
        [];
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

  OrphanageReservationViewModel(this.ref) {
    _orphanageReservationService =
        ref.read(orphanageReservationServiceProvider);
    reservationState.addListener(() {
      if (reservationState.isSuccess) {
        divisionSortList();
      }
    });
  }

  void getInfo(TickerProvider vsync) {
    tabController = TabController(length: list.length, vsync: vsync);
    reservationState.withResponse(
      _orphanageReservationService.getOrphanageVisitReservation(),
    );
  }

  void answerToReservation(int reservationId, String state) {
    reservationState.withResponse(
      _orphanageReservationService.answerToReservation(
        ReservationAnswerRequestDto(
          reservationId: reservationId,
          state: state,
          message: state == "REJECTED" ? "그 날은 소풍 가는 날이라 방문하실 수 없어요..." : "",
        ),
      ),
    );
  }
}
