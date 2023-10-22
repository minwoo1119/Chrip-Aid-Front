import 'package:chrip_aid/common/dio/dio.dart';
import 'package:chrip_aid/orphanage/model/entity/donate_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/update_basket_item_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entity/add_basket_item_entity.dart';
import '../entity/orphanage_basket_entity.dart';

final orphanageBasketRepositoryProvider =
    Provider((ref) => OrphanageBasketRepository(ref.watch(dioProvider)));

class OrphanageBasketRepository {
  final Dio dio;
  final List<AddBasketItemEntity> _savedProducts = [];

  OrphanageBasketRepository(this.dio);

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
        orphanageName: "파주보육원"),
    OrphanageBasketEntity(
        requestId: 2,
        basketProductId: 1,
        productName: "초코파이",
        count: 1,
        price: 8630,
        orphanageName: "파주보육원"),
    OrphanageBasketEntity(
        requestId: 3,
        basketProductId: 3,
        productName: "초코파이",
        count: 1,
        price: 8630,
        orphanageName: "파주보육원"),
    // OrphanageBasketEntity(
    //     requestId: 4,
    //     basketProductId: 1,
    //     productName: "초코파이",
    //     count: 1,
    //     price: 8630,
    //     orphanageName: "파주보육원"),
    // OrphanageBasketEntity(
    //     requestId: 5,
    //     basketProductId: 1,
    //     productName: "초코파이",
    //     count: 1,
    //     price: 8630,
    //     orphanageName: "파주보육원"),
    // OrphanageBasketEntity(
    //     requestId: 6,
    //     basketProductId: 3,
    //     productName: "초코파이",
    //     count: 1,
    //     price: 8630,
    //     orphanageName: "파주보육원"),
  ];

  // 컴포넌트 장바구니 아이콘 클릭 // 엔티티이름 바꿀래
  Future addBasket(AddBasketItemEntity entity) async {
    _savedProducts.add(entity);
    print("요청 아이디 : ${entity.requestId}");
    print("개수 : ${entity.count}");
  }

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
        );
      } else {
        return e;
      }
    }).toList();
  }

  // Future deleteBasket({int? requestId, int? basketProductId}) async {
  //   if(requestId != null) {
  //     list.removeWhere((item) => item.requestId == requestId);
  //   } else if (basketProductId != null) {
  //     list.removeWhere((item) => item.basketProductId == basketProductId);
  //   }
  // }

  Future deleteBasket(int requestId) async {
    list.removeWhere((item) => item.requestId == requestId);
  }

  Future<List<OrphanageBasketEntity>> getOrphanageBasket() async {
/*    final Response response = await dio.get('/orphanages/{$orphanageId}');
    Map<String, dynamic> body = response.data;
    return OrphanageDetailEntity.fromJson(body);*/
    return list;
  }

  Future<List<DonateEntity>> getOrphanageDonate() async {
/*    final Response response = await dio.get('/orphanages/{$orphanageId}');
    Map<String, dynamic> body = response.data;
    return OrphanageDetailEntity.fromJson(body);*/
    return donateList;
  }
}
