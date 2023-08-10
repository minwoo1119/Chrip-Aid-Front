import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_product_service.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_visit_service.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageDetailViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageDetailViewModel(ref));

class OrphanageDetailViewModel extends ChangeNotifier {
  Ref ref;

  late OrphanageState state;
  final dateTextController = TextEditingController(text: '');
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

  void checkCart() {
    ref.read(orphanageProductServiceProvider.notifier).checkCart();
  }

  void postOrCheck(int num) {
    if (num % 2 == 0) {
      checkCart();
    } else {
      post();
    }
  }
}
