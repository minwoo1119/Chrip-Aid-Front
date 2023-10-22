import 'package:chrip_aid/orphanage/model/entity/reservation_entity.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_reservation_service.dart';
import 'package:chrip_aid/orphanage/model/service/reservation_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
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
        divisionSortList();
        notifyListeners();
      }
    });
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
