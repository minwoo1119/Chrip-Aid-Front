import 'package:chrip_aid/common/dio/dio.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_add_product_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_check_product_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_visit_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/request_item_entity.dart';

final orphanageRepositoryProvider =
    Provider((ref) => OrphanageRepository(ref.watch(dioProvider)));

class OrphanageRepository {
  final Dio dio;
  final List<OrphanageAddProductEntity> _savedProducts = [];
  final List<OrphanageCheckProductEntity> _products = [];
  final List<RequestItemEntity> products = [
    RequestItemEntity(
      productPhoto: 'assets/image/choco_pie.jpg',
      productName: "초코파이",
      message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
      price: 8630.0,
      requestCount: 30,
      supportCount: 21,
      requestId: '1',
    ),
    RequestItemEntity(
      productPhoto: 'assets/image/choco_pie.jpg',
      productName: "초코파이",
      message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
      price: 8630.0,
      requestCount: 30,
      supportCount: 21,
      requestId: '2',
    ),
    RequestItemEntity(
      productPhoto: 'assets/image/choco_pie.jpg',
      productName: "초코파이",
      message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
      price: 8630.0,
      requestCount: 30,
      supportCount: 21,
      requestId: '3',
    ),
    RequestItemEntity(
      productPhoto: 'assets/image/choco_pie.jpg',
      productName: "초코파이",
      message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
      price: 8630.0,
      requestCount: 30,
      supportCount: 21,
      requestId: '4',
    ),
  ];

  OrphanageRepository(this.dio);

  // 방문신청 포스트
  Future<OrphanageVisitEntity> post(String data, String purpose) async {
    print(data);
    print(purpose);
    return OrphanageVisitEntity(
      date: data,
      purpose: purpose,
    );
  }

  // 플로팅 액션 장바구니 버튼 클릭
  Future<List<OrphanageCheckProductEntity>> checkCart() async {
    for (int i = 0; i < _products.length; i++) {
      print("요청 아이디 ${_products[i].product.requestId}, 개수 ${_products[i].count}");
    }
    return _products;
  }

  // 컴포넌트 장바구니 아이콘 클릭
  void addItem(String requestId, int count) {
    print(requestId);
    _savedProducts
        .add(OrphanageAddProductEntity(requestId: requestId, count: count));
    print("요청 아이디 : ${requestId}");
    print("개수 : ${count}");
    OrphanageCheckProductEntity item = OrphanageCheckProductEntity(product: products.firstWhere((product) =>
    product.requestId == requestId), count: count);
    _products.add(item);
  }

  Future<OrphanageDetailEntity> getOrphanageDetail(String orphanageId) async {
/*    final Response response = await dio.get('/orphanages/{$orphanageId}');
    Map<String, dynamic> body = response.data;
    return OrphanageDetailEntity.fromJson(body);*/

    await Future.delayed(Duration(seconds: 3));
    return OrphanageDetailEntity(
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
          price: 8630.0,
          requestCount: 30,
          supportCount: 21,
          requestId: '1',
        ),
        RequestItemEntity(
          productPhoto: 'assets/image/choco_pie.jpg',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630.0,
          requestCount: 30,
          supportCount: 21,
          requestId: '2',
        ),
        RequestItemEntity(
          productPhoto: 'assets/image/choco_pie.jpg',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630.0,
          requestCount: 30,
          supportCount: 21,
          requestId: '3',
        ),
        RequestItemEntity(
          productPhoto: 'assets/image/choco_pie.jpg',
          productName: "초코파이",
          message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
          price: 8630.0,
          requestCount: 30,
          supportCount: 21,
          requestId: '4',
        ),
      ],
    );
  }
}
