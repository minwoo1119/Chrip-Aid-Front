import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/reservation/model/service/reservation_service.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:chrip_aid/orphanage/view/orphanage_basket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageDetailViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageDetailViewModel(ref));

class OrphanageDetailViewModel extends ChangeNotifier {
  Ref ref;

  late OrphanageState state;
  final dateTextController = TextEditingController(text: 'Select Date');
  final purposeTextController = TextEditingController(text: '');

  OrphanageDetailEntity get entity => (state as OrphanageStateSuccess).data;

  OrphanageDetailViewModel(this.ref) {
    state = ref.read(orphanageServiceProvider);
    ref.listen(orphanageServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        notifyListeners();
      }
    });
  }

  void postVisitReservation(int orphanageId) {
    ref.read(reservationServiceProvider.notifier).postReservation(

          date: dateTextController.text,
          purpose: purposeTextController.text,
        );
  }

  void goBasket(BuildContext context) {
    context.pushNamed(OrphanageBasketScreen.routeName);
  }


  void postOrGoBasket(int num, BuildContext context) {
    if (num % 2 == 0) {
      goBasket(context);
    } else {
      postVisitReservation(1);
    }
  }
}
