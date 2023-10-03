import 'package:chrip_aid/orphanage/model/entity/orphanage_basket_entity.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_basket_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageBasketViewModelProvider =
ChangeNotifierProvider((ref) => OrphanageBasketViewModel(ref));

class OrphanageBasketViewModel extends ChangeNotifier {
  Ref ref;

  late OrphanageState state;

  OrphanageBasketEntity get entity => (state as OrphanageBasketStateSuccess).data;

  OrphanageBasketViewModel(this.ref) {
    state = ref.read(orphanageBasketServiceProvider);
    ref.listen(orphanageBasketServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        notifyListeners();
      }
    });
  }
}
