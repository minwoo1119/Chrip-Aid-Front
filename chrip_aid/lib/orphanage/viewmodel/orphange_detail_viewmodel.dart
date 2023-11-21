import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/orphanage/component/custom_date_picker.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_basket_service.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:chrip_aid/orphanage/view/orphanage_basket_screen.dart';
import 'package:chrip_aid/reservation/model/entity/orphanage_visit_entity.dart';
import 'package:chrip_aid/reservation/model/service/reservation_service.dart';
import 'package:chrip_aid/reservation/model/state/reservation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageDetailViewModelProvider =
    Provider((ref) => OrphanageDetailViewModel(ref));

class OrphanageDetailViewModel {
  Ref ref;

  late final OrphanageService _orphanageService;

  OrphanageDetailState orphanageDetailState = OrphanageDetailState();

  late final ReservationService _reservationService;

  final ReservationPostState reservationState = ReservationPostState();

  final dateController = CustomDatePickerController(DateTime.now());
  final purposeTextController = TextEditingController(text: '');

  OrphanageDetailViewModel(this.ref) {
    _orphanageService = ref.read(orphanageServiceProvider);
    _reservationService = ref.read(reservationServiceProvider);
  }

  void getInfo(int orphanageId) => orphanageDetailState
      .withResponse(_orphanageService.getOrphanageDetail(orphanageId));

  void postVisitReservation(int orphanageId) {
    reservationState.withResponse(
      _reservationService.postReservation(OrphanageVisitEntity(
        orphanageId: orphanageId,
        visitDate: dateController.value.toString(),
        reason: purposeTextController.text,
      )),
    );
  }

  void goBasket(BuildContext context) async {
    ref.read(orphanageBasketServiceProvider).getOrphanageBasket();
    context.pushNamed(OrphanageBasketScreen.routeName);
  }

  void postOrGoBasket(int num, BuildContext context) {
    if (num % 2 == 0) {
      goBasket(context);
    } else {
      postVisitReservation(orphanageDetailState.value!.orphanageId);
    }
  }
}
