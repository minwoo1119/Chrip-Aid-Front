import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_product_service.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_visit_service.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
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

  void post() {
    ref.read(orphanageVisitServiceProvider.notifier).post(
          date: dateTextController.text,
          purpose: purposeTextController.text,

        );
  }

  void addProduct(String requestId, int count) {
    ref
        .read(orphanageProductServiceProvider.notifier)
        .add(requestId: requestId, count: count);
  }

  Future<Object?> checkCart(BuildContext context) {
    //ref.read(orphanageProductServiceProvider.notifier).checkCart();
    return context.push("/first");
  }

  void postOrCheck(int num, BuildContext context) {
    if (num % 2 == 0) {
      checkCart(context);
    } else {
      post();
    }
  }
}
