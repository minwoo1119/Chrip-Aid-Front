import 'package:chrip_aid/orphanage/model/entity/donate_entity.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_donate_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageDonateViewModelProvider =
ChangeNotifierProvider((ref) => OrphanageDonateViewModel(ref));

class OrphanageDonateViewModel extends ChangeNotifier {
  Ref ref;

  late OrphanageState state;

  List<DonateEntity> get entity =>
      (state as OrphanageDonateStateSuccess).data;

  OrphanageDonateViewModel(this.ref) {
    state = ref.read(orphanageDonateServiceProvider);
    ref.listen(orphanageDonateServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        notifyListeners();
      }
    });
  }
}
