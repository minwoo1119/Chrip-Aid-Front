import 'package:chrip_aid/management/model/dto/add_orphanage_product_request_dto.dart';
import 'package:chrip_aid/management/model/dto/edit_orphanage_info_request_dto.dart';
import 'package:chrip_aid/management/model/repository/orphanage_management_repository.dart';
import 'package:chrip_aid/management/model/state/orphanage_management_state.dart';
import 'package:chrip_aid/member/model/entity/member_entity.dart';
import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageManagementServiceProvider = Provider((ref) {
  final repository = ref.read(orphanageManagementRepositoryProvider);
  return OrphanageManagementService(repository, ref);
});

class OrphanageManagementService {
  final Ref ref;
  late final OrphanageManagementRepository repository;

  final orphanageDetailState = OrphanageDetailState();
  final productListState = OrphanageProductListState();

  OrphanageManagementService(this.repository, this.ref);

  Future getOrphanageInfo() async {
    try {
      orphanageDetailState.loading();
      MemberEntity? member = ref.read(memberInfoServiceProvider).memberInfoState.value;
      if(member is! OrphanageMemberEntity) return;
      int id = (ref.read(memberInfoServiceProvider).memberInfoState.value as OrphanageMemberEntity).orphanageId;
      OrphanageDetailEntity data = await repository.getOrphanageData(id);
      orphanageDetailState.success(value: data);
    } catch (e) {
      orphanageDetailState.error(message: e.toString());
    }
  }

  Future getProductList() async {
    try {
      productListState.loading();
      List<ProductEntity> data = await repository.getProducts();
      productListState.success(value: data);
    } catch (e) {
      productListState.error(message: e.toString());
    }
  }

  Future editOrphanageProduct(AddOrphanageProductRequestDTO dto) async {
    try {
      orphanageDetailState.loading();
      await repository.editOrphanageProduct(dto);
      getOrphanageInfo();
    } catch (e) {
      orphanageDetailState.error(message: e.toString());
    }
  }

  Future editOrphanageInfo(EditOrphanageInfoRequestDTO dto) async {
    try {
      orphanageDetailState.loading();
      await repository.editOrphanageInfo(dto);
      getOrphanageInfo();
    } catch (e) {
      orphanageDetailState.error(message: e.toString());
    }
  }
}
