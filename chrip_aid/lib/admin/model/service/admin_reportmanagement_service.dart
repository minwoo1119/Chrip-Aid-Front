import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/common/entity/response_entity.dart';
import '../dto/admin_report_dto.dart';
import '../entity/report_entity.dart';
import '../repository/admin_reportmanagement_repository.dart';

final adminReportManagementServiceProvider = Provider<AdminReportmanagementService>((ref) {
  final repository = ref.read(adminReportManagementRepositoryProvider);
  return AdminReportmanagementService(repository, ref);
});

class AdminReportmanagementService {
  final Ref ref;
  late final AdminReportmanagementRepository repository;

  AdminReportmanagementService(this.repository, this.ref);

  // 모든 신고 목록 조회
  Future<ResponseEntity<List<ReportEntity>>> getAllReports() async {
    try {
      final List<AdminReportDto> dtoList = await repository.getAllReports();
      final entityList = dtoList.map((dto) => dto.toEntity()).toList();
      return ResponseEntity.success(entity: entityList);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  // 특정 신고 ID로 조회
  Future<ResponseEntity<ReportEntity>> getReportById(String reportId) async {
    try {
      final AdminReportDto dto = await repository.getReportById(reportId);
      final entity = dto.toEntity();
      return ResponseEntity.success(entity: entity);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  // 특정 신고 description으로 조회
  Future<ResponseEntity<List<ReportEntity>>> getReportByDescription(String description) async {
    try {
      final List<AdminReportDto> dtoList = await repository.getReportByDescription(description);
      final entityList = dtoList.map((dto) => dto.toEntity()).toList();
      return ResponseEntity.success(entity: entityList);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }
}
