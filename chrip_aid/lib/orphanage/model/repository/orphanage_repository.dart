import 'package:chrip_aid/common/dio/dio.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_visit_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entity/request_item_entity.dart';

final orphanageRepositoryProvider =
    Provider((ref) => OrphanageRepository(ref.watch(dioProvider)));

class OrphanageRepository {
  final Dio dio;

  OrphanageRepository(this.dio);

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
            price: 8630,
            requestCount: 30,
            supportCount: 21,
            requestId: 1,
            state: "NOT COMPLETED"),
        RequestItemEntity(
            productPhoto: 'assets/image/choco_pie.jpg',
            productName: "초코파이",
            message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
            price: 8630,
            requestCount: 30,
            supportCount: 21,
            requestId: 2,
            state: "NOT COMPLETED"),
        RequestItemEntity(
            productPhoto: 'assets/image/choco_pie.jpg',
            productName: "초코파이",
            message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
            price: 8630,
            requestCount: 30,
            supportCount: 21,
            requestId: 3,
            state: "NOT COMPLETED"),
        RequestItemEntity(
            productPhoto: 'assets/image/choco_pie.jpg',
            productName: "초코파이",
            message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
            price: 8630,
            requestCount: 30,
            supportCount: 21,
            requestId: 4,
            state: "NOT COMPLETED"),
      ],
    );
  }
}
