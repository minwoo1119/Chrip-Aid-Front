import 'package:chrip_aid/management/model/dto/add_orphanage_product_request_dto.dart';
import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/management/model/dto/edit_orphanage_info_request_dto.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';
import 'package:chrip_aid/management/model/repository/orphanage_management_repository.dart';
import 'package:chrip_aid/management/model/state/orphanage_management_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageManagementServiceProvider =
    StateNotifierProvider<OrphanageManagementService, OrphanageManagementState>(
        (ref) => OrphanageManagementService(ref));

class OrphanageManagementService
    extends StateNotifier<OrphanageManagementState> {
  Ref ref;
  late final OrphanageManagementRepository repository;

  OrphanageManagementService(this.ref) : super(OrphanageManagementStateNone()) {
    repository = ref.read(orphanageManagementRepositoryProvider);
    getProductList();
    getOrphanageInfo();
  }

  Future getOrphanageInfo() async {
    try {
      final id = ((ref.read(memberInfoServiceProvider.notifier).state
                  as MemberInfoStateSuccess)
              .data as OrphanageMemberEntity)
          .orphanageId;
      state = OrphanageManagementStateLoading();
      OrphanageDetailEntity data = await repository.getOrphanageData(id);
      state = OrphanageManagementStateSuccess(data);
    } catch (e) {
      state = OrphanageManagementStateError(e.toString());
    }
  }

  Future getProductList() async {
    try {
      List<ProductEntity> data = await repository.getProducts();
      OrphanageManagementState.productList = data;
      state = OrphanageManagementStateNone();
    } catch (e) {
      state = OrphanageManagementStateError(e.toString());
    }
  }

  Future editOrphanageProduct(AddOrphanageProductRequestDTO dto) async {
    try {
      state = OrphanageManagementStateLoading();
      await repository.editOrphanageProduct(dto);
      getOrphanageInfo();
    } catch (e) {
      state = OrphanageManagementStateError(e.toString());
    }
  }

  Future editOrphanageInfo(EditOrphanageInfoRequestDTO dto) async {
    try {
      state = OrphanageManagementStateLoading();
      await repository.editOrphanageInfo(dto);
      getOrphanageInfo();
    } catch (e) {
      state = OrphanageManagementStateError(e.toString());
    }
  }
}
