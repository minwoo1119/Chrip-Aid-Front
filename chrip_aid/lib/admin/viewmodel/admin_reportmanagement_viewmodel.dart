import 'package:chrip_aid/common/value_state/state/value_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/service/admin_reportmanagement_service.dart';
import '../model/entity/report_entity.dart';

final adminReportManagementViewModelProvider =
Provider((ref) => AdminReportmanagementViewmodel(ref));

class AdminReportmanagementViewmodel {
  final Ref ref;
  late final AdminReportmanagementService _adminReportManagementService;

  // StateNotifier 객체
  ValueStateNotifier<List<ReportEntity>> reportsState = ValueStateNotifier();

  AdminReportmanagementViewmodel(this.ref) {
    _adminReportManagementService = ref.read(adminReportManagementServiceProvider);
  }

  // 모든 신고 목록 가져오기
  Future<void> fetchAllReports() async {
    try {
      reportsState.loading(); // 로딩 상태로 설정
      final response = await _adminReportManagementService.getAllReports();

      if (response.isSuccess) {
        reportsState.success(value: response.entity!); // 성공 상태로 설정 및 데이터 저장
      } else {
        reportsState.error(message: response.message ?? 'Unknown error occurred');
      }
    } catch (e) {
      reportsState.error(message: e.toString()); // 에러 발생 시 에러 상태 설정
    }
  }
}
