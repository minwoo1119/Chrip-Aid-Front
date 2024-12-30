import 'package:chrip_aid/admin/model/state/admin_detail_state.dart';
import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/management/model/dto/add_orphanage_product_request_dto.dart';
import 'package:chrip_aid/management/model/dto/edit_orphanage_info_request_dto.dart';
import 'package:chrip_aid/management/model/repository/orphanage_management_repository.dart';
import 'package:chrip_aid/member/model/entity/member_entity.dart';
import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageManagementServiceProvider = Provider((ref) {
  final repository = ref.read(orphanageManagementRepositoryProvider);
  return OrphanageManagementService(repository, ref);
});

class OrphanageManagementService {
  final Ref ref;
  late final OrphanageManagementRepository repository;

  OrphanageManagementService(this.repository, this.ref);

  Future<ResponseEntity<OrphanageDetailEntity>> getOrphanageInfo() async {
    try {
      List<OrphanageMemberEntity> orphanageMember = OrphanageListState().value!;
      if (orphanageMember is! OrphanageMemberEntity) {
        return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
      }
      String id = orphanageMember.toString();
      OrphanageDetailEntity data = await repository.getOrphanageData(id);
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity<List<ProductEntity>>> getProductList(String search) async {
    try {
      List<ProductEntity> data = await repository.getProducts(search);
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity<OrphanageDetailEntity>> editOrphanageProduct(
    AddOrphanageProductRequestDTO dto,
  ) async {
    try {
      await repository.editOrphanageProduct(dto);
      return getOrphanageInfo();
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity> editOrphanageInfo(
    EditOrphanageInfoRequestDTO dto,
  ) async {
    try {
      await repository.editOrphanageInfo(dto);
      return ResponseEntity.success();
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }
}
