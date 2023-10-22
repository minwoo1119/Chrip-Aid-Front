import 'package:chrip_aid/orphanage/model/repository/orphanage_repository.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageProductServiceProvider = StateNotifierProvider<OrphanageProductService, OrphanageState>(
        (ref) => OrphanageProductService(ref.watch(orphanageRepositoryProvider)));

class OrphanageProductService extends StateNotifier<OrphanageState> {
  final OrphanageRepository repository;


  OrphanageProductService(this.repository) : super(OrphanageProductStateNone());

}
