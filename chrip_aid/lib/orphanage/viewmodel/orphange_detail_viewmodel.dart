import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/utils/snack_bar_util.dart';
import 'package:chrip_aid/orphanage/component/custom_date_picker.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_basket_service.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:chrip_aid/orphanage/view/orphanage_basket_screen.dart';
import 'package:chrip_aid/reservation/model/entity/orphanage_visit_entity.dart';
import 'package:chrip_aid/reservation/model/service/reservation_service.dart';
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

  late OrphanageState reservationState;
  final dateController = CustomDatePickerController(DateTime.now());
  final purposeTextController = TextEditingController(text: '');

  OrphanageDetailEntity? get entity => orphanageDetailState.value;

  OrphanageDetailViewModel(this.ref) {
    _orphanageService = ref.read(orphanageServiceProvider);
    orphanageDetailState.addListener(notifyListeners);

    reservationState = ref.read(reservationServiceProvider);
    ref.listen(reservationServiceProvider, (previous, next) {
      reservationState = next;
      if (reservationState is ErrorState) {
        SnackBarUtil.showError((reservationState as ErrorState).message);
      }
      if (reservationState is SuccessState) {
        SnackBarUtil.showSuccess("예약에 성공했습니다.");
      }
      notifyListeners();
    });
  }

  void postVisitReservation(int orphanageId) {
    ref
        .read(reservationServiceProvider.notifier)
        .postReservation(OrphanageVisitEntity(
          orphanageId: orphanageId,
          visitDate: dateController.value.toString(),
          reason: purposeTextController.text,
        ));
  }

  void goBasket(BuildContext context) async {
    ref.read(orphanageBasketServiceProvider.notifier).getOrphanageBasket();
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
