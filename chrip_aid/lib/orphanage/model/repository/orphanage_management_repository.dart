import 'package:chrip_aid/common/dio/dio.dart';
import 'package:chrip_aid/orphanage/model/dto/orphanage_product_add_request_dto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'orphanage_management_repository.g.dart';

final orphanageManagementRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return OrphanageManagementRepository(dio);
});

@RestApi()
abstract class OrphanageManagementRepository {
  factory OrphanageManagementRepository(Dio dio, {String? baseUrl}) =
      _OrphanageManagementRepository;

  @POST('/requests')
  @Headers({'accessToken': 'true'})
  Future editOrphanageProduct(@Body() OrphanageProductAddRequestDTO entity);
}
