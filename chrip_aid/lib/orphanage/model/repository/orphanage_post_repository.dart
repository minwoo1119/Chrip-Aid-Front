import 'package:chrip_aid/common/dio/dio.dart';
import 'package:chrip_aid/orphanage/model/entity/get_posts_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanagePostRepositoryProvider =
    Provider((ref) => OrphanagePostRepository(ref.watch(dioProvider)));

class OrphanagePostRepository {
  final Dio dio;

  OrphanagePostRepository(this.dio);

  List<GetPostsEntity> postList = [
    GetPostsEntity(
        reviewId: 1,
        title: "기부 받은 감사 인증글",
        content: "보육원에서 여러분의 따뜻한 성금과 도움으로 마련한 물품을 사용했어요. 아이들은 기부 받은 과자들로 웃음 가득한 하루를 보내게 되었습니다. 감사합니다!",
        photo: ['assets/image/pajukids_house.jpg'],
        date: "2023-09-26 10:44:37",
        name: "고길동",
        orphanageName: "파주 보육원",
        productNames: ["마가렛트", "초코파이","마가렛트", "초코파이","마가렛트", "초코파이","마가렛트", "초코파이","마가렛트", "초코파이","마가렛트", "초코파이","마가렛트", "초코파이","마가렛트", "초코파이","마가렛트", "초코파이",]),
    GetPostsEntity(
        reviewId: 2,
        title: "기부 받은 감사 인증글",
        content: "보육원에서 여러분의 따뜻한 성금과 도움으로 마련한 물품을 사용했어요. 아이들은 기부 받은 과자들로 웃음 가득한 하루를 보내게 되었습니다. 감사합니다!",
        photo: ['assets/image/pajukids_house.jpg'],
        date: "2023-09-26 10:44:37",
        name: "고길동",
        orphanageName: "파주 보육원",
        productNames: ["마가렛트", "초코파이"]),
    GetPostsEntity(
        reviewId: 3,
        title: "기부 받은 감사 인증글",
        content: "보육원에서 여러분의 따뜻한 성금과 도움으로 마련한 물품을 사용했어요. 아이들은 기부 받은 과자들로 웃음 가득한 하루를 보내게 되었습니다. 감사합니다!",
        photo: ['assets/image/pajukids_house.jpg'],
        date: "2023-09-26 10:44:37",
        name: "고길동",
        orphanageName: "파주 보육원",
        productNames: ["마가렛트", "초코파이"]),
    GetPostsEntity(
        reviewId: 4,
        title: "기부 받은 감사 인증글",
        content: "보육원에서 여러분의 따뜻한 성금과 도움으로 마련한 물품을 사용했어요. 아이들은 기부 받은 과자들로 웃음 가득한 하루를 보내게 되었습니다. 감사합니다!",
        photo: ['assets/image/pajukids_house.jpg'],
        date: "2023-09-26 10:44:37",
        name: "고길동",
        orphanageName: "파주 보육원",
        productNames: ["마가렛트", "초코파이"]),
  ];

  Future<List<GetPostsEntity>> getOrphanagePosts() async {
/*    final Response response = await dio.get('/orphanages/{$orphanageId}');
    Map<String, dynamic> body = response.data;
    return OrphanageDetailEntity.fromJson(body);*/
    return postList;
  }
}
