import 'package:chrip_aid/common/dio/dio.dart';
import 'package:chrip_aid/management/model/dto/add_orphanage_product_request_dto.dart';
import 'package:chrip_aid/management/model/dto/edit_orphanage_info_request_dto.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'admin_reportmanagement_repository.g.dart';

final adminReportManagementRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  // return OrphanageManagementRepositoryStub();
  return AdminReportmanagementRepository(dio);
});

@RestApi()
abstract class AdminReportmanagementRepository {
  factory AdminReportmanagementRepository(Dio dio, {String? baseUrl}) =
  _AdminReportmanagementRepository;

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