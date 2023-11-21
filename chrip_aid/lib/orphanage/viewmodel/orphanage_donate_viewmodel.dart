import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_donate_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageDonateViewModelProvider =
    Provider((ref) => OrphanageDonateViewModel(ref));

class OrphanageDonateViewModel {
  Ref ref;

  late final OrphanageDonateService _orphanageDonateService;
  OrphanageDonateState state = OrphanageDonateState();

  OrphanageDonateViewModel(this.ref) {
    _orphanageDonateService = ref.read(orphanageDonateServiceProvider);
  }

  void getInfo() => state.withResponse(
        _orphanageDonateService.getOrphanageDonate(),
      );
}
