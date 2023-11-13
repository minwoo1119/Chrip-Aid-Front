import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/utils/snack_bar_util.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_answer_request_dto.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';
import 'package:chrip_aid/reservation/model/service/orphanage_reservation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageReservationViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageReservationViewModel(ref));

class OrphanageReservationViewModel extends ChangeNotifier {
  Ref ref;

  late OrphanageState state;
  String? selectedTabIndex;
  List<OrphanageReservationEntity> listAll = [];
  List<OrphanageReservationEntity> listEnd = [];
  List<OrphanageReservationEntity> listPending = [];
  List<OrphanageReservationEntity> listApprove = [];

  // List<OrphanageReservationEntity> get entity =>
  //     (state as OrphanageReservationStateSuccess).data;

  // List<ReservationEntity> get filteredEntity {
  //   return (state as OrphanageReservationStateSuccess)
  //       .data
  //       .where((item) =>
  //           selectedTabIndex == null ||
  //           item.state == selectedTabIndex ||
  //           (selectedTabIndex == "ENDED" &&
  //               (item.state == "REJECTED" || item.state == "COMPLETED")))
  //       .toList();
  // }

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
    listApprove = (state as OrphanageReservationStateSuccess)
        .data
        .where((item) => item.state == "APPROVED")
        .toList();
    listPending = (state as OrphanageReservationStateSuccess)
        .data
        .where((item) => item.state == "PENDING")
        .toList();
    listEnd = (state as OrphanageReservationStateSuccess)
        .data
        .where((item) => item.state == "REJECTED" || item.state == "COMPLETED")
        .toList();
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
    state = ref.read(orphanageReservationServiceProvider);
    ref.listen(orphanageReservationServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        if (next is ErrorState) {
          SnackBarUtil.showError((next as ErrorState).message);
        }
        if (next is SuccessState) {
          divisionSortList();
        }
        notifyListeners();
      }
    });
  }

  void answerToReservation(int reservationId, String state) {
    ref.read(orphanageReservationServiceProvider.notifier).answerToReservation(
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
