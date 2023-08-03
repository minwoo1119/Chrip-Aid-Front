import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageDetailViewModelProvider = ChangeNotifierProvider((ref) => OrphanageDetailViewModel(ref));

class OrphanageDetailViewModel extends ChangeNotifier {
  Ref ref;

  late OrphanageState state;

  OrphanageDetailEntity get entity => (state as OrphanageStateSuccess).data;

  OrphanageDetailViewModel(this.ref) {
    state = ref.read(orphanageServiceProvider);
    ref.listen(orphanageServiceProvider, (previous, next) {
      if(previous != next) {
        state = next;
        notifyListeners();
      }
    });
  }
}