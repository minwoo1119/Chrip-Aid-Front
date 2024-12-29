import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/component/custom_report_list.dart';
import '../../common/component/custom_toggle_button.dart';
import '../../common/styles/colors.dart';
import '../../common/styles/sizes.dart';
import '../../common/value_state/component/value_state_listener.dart';
import '../../common/value_state/state/value_state.dart';
import '../../orphanage/layout/detail_page_layout.dart';
import '../model/entity/report_entity.dart';
import '../viewmodel/admin_reportmanagement_viewmodel.dart';

class AdminReportManagementScreen extends ConsumerWidget {
  static String get routeName => "reportmanagement";

  const AdminReportManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(adminReportManagementViewModelProvider);
    final reportsState = ref.watch(adminReportManagementViewModelProvider).reportsState;
    final isUserState = ref.watch(isUserFilterProvider);

    // 화면이 처음 로드될 때 데이터 가져오기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchAllReports();
    });

    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '신고 관리',
      titleColor: Colors.white,
      appBarBackgroundColor: CustomColor.buttonMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      leadingColor: CustomColor.textReverseColor,
      actions: [
        const SizedBox(width: kPaddingMiddleSize),
      ],
      child: ValueStateListener(
        state: reportsState,
        defaultBuilder: (_, state) => const Center(
          child: CircularProgressIndicator(),
        ),
        successBuilder: (_, state) {
          final List<ReportEntity> reports = state.value ?? [];

          // 사용자/게시글 필터링된 데이터
          final filteredData = reports
              .where((report) => isUserState ? report.targetType == 'USER' : report.boardType != null)
              .toList();

          if (filteredData.isEmpty) {
            return Center(
              child: Text('데이터가 없습니다.'),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.0),
                CustomToggleButton(
                  options: ['사용자', '게시글'],
                  onChanged: (index) {
                    // isUser 상태 변경 (사용자가 클릭한 토글에 따라 상태 변경)
                    ref.read(isUserFilterProvider.notifier).state = index == 0;
                  },
                ),
                SizedBox(height: 10.0),
                Column(
                  children: filteredData.map((report) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: CustomReportList(
                        title: report.boardTitle ?? report.description,
                        reporterName: report.reporterName,
                        targetName: report.targetName ?? report.targetName ?? 'N/A',
                        onTap: () => _navigateToDetailPage(context, report),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
        errorBuilder: (_, error) {
          final errorMessage = error is ValueStateNotifier ? error.message : '알 수 없는 오류가 발생했습니다.';
          return Center(
            child: Text('오류 발생: $errorMessage'),
          );
        },
      ),
    );
  }

  void _navigateToDetailPage(BuildContext context, dynamic reportData) {
    context.push(
      '/supervisor/reportmanagement/detail',
      extra: reportData,
    );
  }
}

// isUser 필터 상태 관리
final isUserFilterProvider = StateProvider<bool>((ref) => true);
