import 'package:chrip_aid/common/dio/dio.dart';
import 'package:chrip_aid/management/model/dto/add_orphanage_product_request_dto.dart';
import 'package:chrip_aid/management/model/dto/edit_orphanage_info_request_dto.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';


final supervisorAccountManagementRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  // return OrphanageManagementRepositoryStub();
  return SupervisorAccountManagementRepository(dio);
});

@RestApi()
abstract class SupervisorAccountManagementRepository {
  factory SupervisorAccountManagementRepository(Dio dio, {String? baseUrl}) =
  _SupervisorAccountManagementRepository;

  // TODO : 아래 부분 수정해야함
  @GET('/orphanages/{id}')
  @Headers({'accessToken': 'true'})
  Future<OrphanageDetailEntity> getOrphanageData(@Path("id") int id);

  @PATCH('/orphanages')
  @Headers({'accessToken': 'true'})
  Future editOrphanageInfo(@Body() EditOrphanageInfoRequestDTO dto);

  @POST('/requests')
  @Headers({'accessToken': 'true'})
  Future editOrphanageProduct(@Body() AddOrphanageProductRequestDTO dto);

  @GET('/requests/products')
  @Headers({'accessToken': 'true'})
  Future<List<ProductEntity>> getProducts();
}