import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
import 'package:chrip_aid/orphanage/component/orphanage_reservation_box.dart';
import 'package:chrip_aid/orphanage/const/tabs.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';
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
  late final OrphanageReservationViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ref.read(orphanageReservationViewModelProvider)..getInfo(this);
  }

  @override
  Widget build(BuildContext context) {
    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      appBarBackgroundColor: CustomColor.backgroundMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      title: "방문예약 확인",
      child: ValueStateListener(
        state: viewModel.reservationState,
        successBuilder: (_, state) => Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              controller: viewModel.tabController,
              tabs: tabReservation,
              indicatorColor: Colors.black,
              onTap: (index) {
                viewModel.changeSelectedTab(index);
              },
            ),
            Expanded(
              child: TabBarView(
                controller: viewModel.tabController,
                children: viewModel.list
                    .map((e) => _ReservationTabView(
                          list: e,
                          onAnswer: viewModel.answerToReservation,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReservationTabView extends StatelessWidget {
  final List<OrphanageReservationEntity> list;
  final void Function(int, String) onAnswer;

  const _ReservationTabView({
    Key? key,
    required this.list,
    required this.onAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
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
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
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
                  onAnswer: (state) => onAnswer(
                    item.reservationId,
                    state,
                  ),
                );
              },
            ),
          );
  }
}
