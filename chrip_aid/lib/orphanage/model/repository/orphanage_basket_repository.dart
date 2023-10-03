import 'package:chrip_aid/common/dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entity/orphanage_basket_entity.dart';

final orphanageBasketRepositoryProvider =
Provider((ref) => OrphanageBasketRepository(ref.watch(dioProvider)));

class OrphanageBasketRepository {
  final Dio dio;
  OrphanageBasketRepository(this.dio);

  Future<OrphanageBasketEntity> getOrphanageBasket(String orphanageId) async {
/*    final Response response = await dio.get('/orphanages/{$orphanageId}');
    Map<String, dynamic> body = response.data;
    return OrphanageDetailEntity.fromJson(body);*/

    await Future.delayed(Duration(seconds: 3));
    return OrphanageBasketEntity(basketProductId: 1, productName: "초코파이", count: 3, price: 8630, orphanageName: "파주보육원");
  }
}
