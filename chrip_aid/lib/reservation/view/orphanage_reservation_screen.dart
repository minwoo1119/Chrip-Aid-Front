import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/orphanage/component/orphanage_reservation_box.dart';
import 'package:chrip_aid/orphanage/const/tabs.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:chrip_aid/reservation/viewmodel/orphanage_reservation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrphanageReservationScreen extends ConsumerStatefulWidget
    implements ReservationScreen {
  const OrphanageReservationScreen({super.key});

  @override
  OrphanageReservationScreenState createState() =>
      OrphanageReservationScreenState();
}

class OrphanageReservationScreenState
    extends ConsumerState<OrphanageReservationScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(orphanageReservationViewModelProvider);
    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      appBarBackgroundColor: CustomColor.backgroundMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      title: "방문예약 확인",
      child: viewModel.state.isSuccess
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
                Expanded(
                  child: viewModel.filteredEntity.isEmpty
                      ? Container(
                          width: double.infinity,
                          color: CustomColor.disabledColor,
                          child: Column(
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
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          color: CustomColor.disabledColor,
                          child: ListView.builder(
                            itemCount: viewModel.filteredEntity.length,
                            itemBuilder: (context, index) {
                              final item = viewModel.filteredEntity[index];
                              return OrphanageReservationBox(
                                name: item.name,
                                age: item.age.toString(),
                                sex: item.sex,
                                region: item.region,
                                phoneNumber: item.phoneNumber,
                                writeDate: item.writeDate,
                                visitDate: item.visitDate,
                                reason: item.reason,
                                state: item.state,
                                rejectReason: item.rejectReason ?? '',
                                onAnswer: (state) => viewModel.answerToReservation(item.reservationId, state),
                              );
                            },
                          ),
                        ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
