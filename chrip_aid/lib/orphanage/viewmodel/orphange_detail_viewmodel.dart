import 'package:chrip_aid/common/utils/log_util.dart';
import 'package:chrip_aid/orphanage/component/custom_date_picker.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
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
    ChangeNotifierProvider((ref) => OrphanageDetailViewModel(ref));

class OrphanageDetailViewModel extends ChangeNotifier {
  Ref ref;

  late final OrphanageService _orphanageService;

  OrphanageDetailState get orphanageDetailState =>
      _orphanageService.orphanageDetailState;

  late final ReservationService _reservationService;

  ReservationState get reservationState => _reservationService.state;

  final dateController = CustomDatePickerController(DateTime.now());
  final purposeTextController = TextEditingController(text: '');

  OrphanageDetailEntity? get entity => orphanageDetailState.value;

  OrphanageDetailViewModel(this.ref) {
    _orphanageService = ref.read(orphanageServiceProvider);
    _reservationService = ref.read(reservationServiceProvider);

    orphanageDetailState.addListener(() {
      logging("OrphanageDetailViewModel", "orphanageDetailState.isSuccess : ${orphanageDetailState.isSuccess}");
      notifyListeners();
    });
  }

  void postVisitReservation(int orphanageId) {
    _reservationService.postReservation(OrphanageVisitEntity(
      orphanageId: orphanageId,
      visitDate: dateController.value.toString(),
      reason: purposeTextController.text,
    ));
  }

  void goBasket(BuildContext context) async {
    ref.read(orphanageBasketServiceProvider).getOrphanageBasket();
    context.pushNamed(OrphanageBasketScreen.routeName);
  }

  void postOrGoBasket(int num, BuildContext context) {
    if (entity == null) return;
    if (num % 2 == 0) {
      goBasket(context);
    } else {
      postVisitReservation(entity!.orphanageId);
    }
  }
}
