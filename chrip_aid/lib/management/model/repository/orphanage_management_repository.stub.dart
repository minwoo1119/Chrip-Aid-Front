import 'package:chrip_aid/management/model/dto/add_orphanage_product_request_dto.dart';
import 'package:chrip_aid/management/model/dto/edit_orphanage_info_request_dto.dart';
import 'package:chrip_aid/management/model/repository/orphanage_management_repository.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/request_item_entity.dart';

class OrphanageManagementRepositoryStub
    implements OrphanageManagementRepository {
  @override
  Future editOrphanageInfo(EditOrphanageInfoRequestDTO dto) async {}

  @override
  Future editOrphanageProduct(AddOrphanageProductRequestDTO dto) async {}

  @override
  Future<OrphanageDetailEntity> getOrphanageData(String id) async {
    return OrphanageDetailEntity(
      orphanageName: '파주 보육원',
      address: '경기도 파주시 법원읍 술이홀로907번길 139',
      phoneNumber: '031)958-7176',
      photo: 'https://picsum.photos/300/300',
      homepageLink: 'www.pajukids.com',
      name: '윤하경',
      description:
          '사시사철 웃음가득, 기쁨 가득 파주키즈 동산에 방문하신 여러분을 환영합니다! 아이들을 사랑하는 마음들이 모아져 여러분들과 함께 기쁨의 공간을 채우고 나누게 되어 매우 기쁘게 생각합니다.',
      requests: [
        RequestItemEntity(
          productPhoto: 'https://picsum.photos/300/300',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630,
          requestCount: 30,
          supportCount: 21,
          requestId: 1,
          state: 'COMPLETED',
        ),
        RequestItemEntity(
          productPhoto: 'https://picsum.photos/300/300',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630,
          requestCount: 30,
          supportCount: 21,
          state: 'COMPLETED',
          requestId: 2,
        ),
        RequestItemEntity(
          productPhoto: 'https://picsum.photos/300/300',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630,
          requestCount: 30,
          supportCount: 21,
          state: 'COMPLETED',
          requestId: 3,
        ),
        RequestItemEntity(
          productPhoto: 'https://picsum.photos/300/300',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630,
          requestCount: 30,
          supportCount: 21,
          state: 'COMPLETED',
          requestId: 4,
        ),
        RequestItemEntity(
          productPhoto: 'https://picsum.photos/300/300',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630,
          requestCount: 30,
          supportCount: 21,
          state: 'COMPLETED',
          requestId: 4,
        ),
        RequestItemEntity(
          productPhoto: 'https://picsum.photos/300/300',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630,
          requestCount: 30,
          supportCount: 21,
          state: 'COMPLETED',
          requestId: 4,
        ),
        RequestItemEntity(
          productPhoto: 'https://picsum.photos/300/300',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630,
          requestCount: 30,
          supportCount: 21,
          state: 'COMPLETED',
          requestId: 4,
        ),
      ],
      orphanageId: 1,
    );
  }

  @override
  Future<List<ProductEntity>> getProducts(String query) async {
    return [
      ProductEntity(
          title: "초코파이",
          price: '5000',
          image: "https://picsum.photos/300/300",
          link: 'https://search.shopping.naver.com/catalog/9992361572'),
      ProductEntity(
          title: "초코파이",
          price: '5000',
          image: "https://picsum.photos/300/300",
          link: 'https://search.shopping.naver.com/catalog/9992361572'),
      ProductEntity(
          title: "초코파이",
          price: '5000',
          image: "https://picsum.photos/300/300",
          link: 'https://search.shopping.naver.com/catalog/9992361572'),
      ProductEntity(
          title: "초코파이",
          price: '5000',
          image: "https://picsum.photos/300/300",
          link: 'https://search.shopping.naver.com/catalog/9992361572'),
    ];
  }
}
