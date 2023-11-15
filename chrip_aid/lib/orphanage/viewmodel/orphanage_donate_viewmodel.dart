import 'package:chrip_aid/orphanage/model/entity/donate_entity.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_donate_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageDonateViewModelProvider =
ChangeNotifierProvider((ref) => OrphanageDonateViewModel(ref));

class OrphanageDonateViewModel extends ChangeNotifier {
  Ref ref;

  late final OrphanageDonateService _orphanageDonateService;
  OrphanageDonateState get state => _orphanageDonateService.donateState;

  List<DonateEntity>? get entity => state.value;

  OrphanageDonateViewModel(this.ref) {
    _orphanageDonateService = ref.read(orphanageDonateServiceProvider);
    state.addListener(notifyListeners);
  }
}
