import 'package:chrip_aid/orphanage/model/dto/donate_delete_dto.dart';
import 'package:chrip_aid/orphanage/model/dto/donate_request_dto.dart';
import 'package:chrip_aid/orphanage/model/entity/donate_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/update_basket_item_entity.dart';
import 'package:chrip_aid/orphanage/model/repository/orphanage_basket_repository.dart';
import '../entity/add_basket_item_entity.dart';
import '../entity/orphanage_basket_entity.dart';

class OrphanageBasketRepositoryStub implements OrphanageBasketRepository {
  List<DonateEntity> donateList = [
    DonateEntity(
        orphanageName: "파주보육원",
        date: "2023-10-05 03:34:22",
        productName: "초코파이",
        price: 8630,
        count: 5,
        message: "초코파이 많이 먹어!"),
    DonateEntity(
        orphanageName: "금오보육원",
        date: "2023-10-06 03:34:22",
        productName: "촉촉한 초코칩",
        price: 2000,
        count: 3,
        message: "냠냠"),
    DonateEntity(
        orphanageName: "아라보육원",
        date: "2023-10-07 03:34:22",
        productName: "초코파이",
        price: 8630,
        count: 5,
        message: "초코파이 많이 먹어!"),
    DonateEntity(
        orphanageName: "효돈보육원",
        date: "2023-10-08 03:34:22",
        productName: "촉촉한 초코칩",
        price: 2000,
        count: 2,
        message: "냠냠"),
  ];

  List<OrphanageBasketEntity> list = [
    OrphanageBasketEntity(
      requestId: 1,
      basketProductId: 1,
      productName: "초코파이",
      count: 1,
      price: 8630,
      orphanageName: "파주보육원",
      productPhoto: 'https://picsum.photos/300/300',
    ),
    OrphanageBasketEntity(
      requestId: 2,
      basketProductId: 1,
      productName: "초코파이",
      count: 1,
      price: 8630,
      orphanageName: "파주보육원",
      productPhoto: 'https://picsum.photos/300/300',
    ),
    OrphanageBasketEntity(
      requestId: 3,
      basketProductId: 3,
      productName: "초코파이",
      count: 1,
      price: 8630,
      orphanageName: "파주보육원",
      productPhoto: 'https://picsum.photos/300/300',
    ),
  ];

  @override
  Future addBasket(AddBasketItemEntity entity) async {}

  @override
  Future updateBasket(UpdateBasketItemEntity entity) async {
    list = list.map((e) {
      if (e.requestId == entity.requestId) {
        return OrphanageBasketEntity(
            requestId: e.requestId,
            basketProductId: e.basketProductId,
            productName: e.productName,
            count: entity.count,
            price: e.price,
            orphanageName: e.orphanageName,
            productPhoto: e.productPhoto);
      } else {
        return e;
      }
    }).toList();
  }

  @override
  Future deleteBasket(DonateDeleteDto dto) async {
    list.removeWhere((item) => item.requestId == dto.basketProductId);
  }

  @override
  Future<List<OrphanageBasketEntity>> getOrphanageBasket() async {
    return list;
  }

  @override
  Future<List<DonateEntity>> getOrphanageDonate(String type) async {
    return donateList;
  }

  @override
  Future donate(DonateRequestDTO dto) async {}
}
