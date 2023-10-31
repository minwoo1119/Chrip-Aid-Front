import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/orphanage/component/custom_reservation_box.dart';
import 'package:chrip_aid/orphanage/const/tabs.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/reservation/viewmodel/user_reservation_viewmodel.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserReservationScreen extends ConsumerStatefulWidget
    implements ReservationScreen {
  const UserReservationScreen({super.key});

  @override
  UserReservationScreenState createState() => UserReservationScreenState();
}

class UserReservationScreenState extends ConsumerState<UserReservationScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;

  // late final OrphanageReservationViewModel viewModel;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {
        // viewModel.changeSelectedTab(tabController.index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO : Fix Layout Error
    final viewModel = ref.watch(reservationViewModelProvider);
    return DetailPageLayout(
      appBarBackgroundColor: CustomColor.backgroundMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      title: "방문예약 확인",
      child: viewModel.state is SuccessState
          ? Column(
              children: [
                TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  controller: tabController,
                  tabs: tabReservation,
                  indicatorColor: Colors.black,
                  onTap: (index) {
                    viewModel.changeSelectedTab(index);
                  },
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Expanded(
                    child: viewModel.filteredEntity.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.white.withOpacity(0.5),
                                size: 90,
                              ),
                              Text(
                                "내역이 존재하지 않습니다",
                                style: kTextReverseStyleSmall.copyWith(
                                    color: Colors.white.withOpacity(0.5)),
                              ),
                            ],
                          )
                        : Container(
                            color: CustomColor.disabledColor,
                            child: ListView.builder(
                              itemCount: viewModel.filteredEntity.length,
                              itemBuilder: (context, index) {
                                final item = viewModel.filteredEntity[index];
                                return CustomReservationBox(
                                    orphanageName: item.orphanageName,
                                    writeDate: item.writeDate,
                                    visitDate: item.visitDate,
                                    reason: item.reason,
                                    state: item.state,
                                    rejectReason: item.rejectReason);
                              },
                            ),
                          ))
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
