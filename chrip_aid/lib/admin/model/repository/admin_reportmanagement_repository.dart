import 'package:chrip_aid/admin/model/dto/admin_report_dto.dart';
import 'package:chrip_aid/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'admin_reportmanagement_repository.g.dart';

final adminReportManagementRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AdminReportmanagementRepository(dio);
});

@RestApi()
abstract class AdminReportmanagementRepository {
  factory AdminReportmanagementRepository(Dio dio, {String? baseUrl}) =
  _AdminReportmanagementRepository;

  // 모든 신고 조회
  @GET('/admin/reports')
  @Headers({'accessToken': 'true'})
  Future<List<AdminReportDto>> getAllReports();

  // 특정 신고 ID 조회
  @GET('/admin/reports/id')
  @Headers({'accessToken': 'true'})
  Future<AdminReportDto> getReportById(@Query('id') String id);

  // 특정 신고 description 조회
  @GET('/admin/reports/desc')
  @Headers({'accessToken': 'true'})
  Future<List<AdminReportDto>> getReportByDescription(@Query('desc') String description);
}
