import 'package:chrip_aid/management/model/dto/add_orphanage_product_request_dto.dart';
import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/management/model/dto/edit_orphanage_info_request_dto.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/request_item_entity.dart';
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
    getProductList();
    getOrphanageInfo();
    repository = ref.read(orphanageManagementRepositoryProvider);
  }

  Future getOrphanageInfo() async {
    return state = OrphanageManagementStateSuccess(OrphanageDetailEntity(
      orphanageName: '파주 보육원',
      address: '경기도 파주시 법원읍 술이홀로907번길 139',
      phoneNumber: '031)958-7176',
      photo: 'assets/image/pajukids_house.jpg',
      homepageLink: 'www.pajukids.com',
      name: '윤하경',
      description:
      '사시사철 웃음가득, 기쁨 가득 파주키즈 동산에 방문하신 여러분을 환영합니다! 아이들을 사랑하는 마음들이 모아져 여러분들과 함께 기쁨의 공간을 채우고 나누게 되어 매우 기쁘게 생각합니다.',
      requests: [
        RequestItemEntity(
          productPhoto: 'assets/image/choco_pie.jpg',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630,
          requestCount: 30,
          supportCount: 21,
          requestId: 1,
        ),
        RequestItemEntity(
          productPhoto: 'assets/image/choco_pie.jpg',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630,
          requestCount: 30,
          supportCount: 21,
          requestId: 2,
        ),
        RequestItemEntity(
          productPhoto: 'assets/image/choco_pie.jpg',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630,
          requestCount: 30,
          supportCount: 21,
          requestId: 3,
        ),
        RequestItemEntity(
          productPhoto: 'assets/image/choco_pie.jpg',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630,
          requestCount: 30,
          supportCount: 21,
          requestId: 4,
        ),
        RequestItemEntity(
          productPhoto: 'assets/image/choco_pie.jpg',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630,
          requestCount: 30,
          supportCount: 21,
          requestId: 4,
        ),
        RequestItemEntity(
          productPhoto: 'assets/image/choco_pie.jpg',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630,
          requestCount: 30,
          supportCount: 21,
          requestId: 4,
        ),
        RequestItemEntity(
          productPhoto: 'assets/image/choco_pie.jpg',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630,
          requestCount: 30,
          supportCount: 21,
          requestId: 4,
        ),
      ],
    ));
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
    OrphanageManagementState.productList = [
      ProductEntity(id: 1, productName: "초코파이", price: 5000, image: "assets/image/choco_pie.jpg"),
      ProductEntity(id: 1, productName: "초코파이", price: 5000, image: "assets/image/choco_pie.jpg"),
      ProductEntity(id: 1, productName: "초코파이", price: 5000, image: "assets/image/choco_pie.jpg"),
      ProductEntity(id: 1, productName: "초코파이", price: 5000, image: "assets/image/choco_pie.jpg"),
      ProductEntity(id: 1, productName: "초코파이", price: 5000, image: "assets/image/choco_pie.jpg"),
    ];
    return OrphanageManagementStateNone();
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
