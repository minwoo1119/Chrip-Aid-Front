import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
import 'package:chrip_aid/orphanage/component/custom_reservation_box.dart';
import 'package:chrip_aid/orphanage/const/tabs.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:chrip_aid/reservation/viewmodel/user_reservation_viewmodel.dart';
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
  late final ReservationViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ref.read(reservationViewModelProvider)..getInfo(this);
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
                    .map((e) => _ReservationTabView(list: e))
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
  final List<ReservationEntity> list;

  const _ReservationTabView({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: CustomColor.disabledColor,
      child: list.isEmpty
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
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return CustomReservationBox(
                  orphanageName: item.orphanageName,
                  writeDate: item.writeDate,
                  visitDate: item.visitDate,
                  reason: item.reason,
                  state: item.state,
                  rejectReason: item.rejectReason,
                );
              },
            ),
    );
  }
}
