import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../admin/view/admin_accountmanagement_screen.dart';
import '../../admin/view/admin_postmanagement_screen.dart';
import '../../admin/view/admin_reportmanagement_screen.dart';

final supervisorHomeViewModelProvider = Provider((ref) => SupervisorViewModel(ref));

class SupervisorViewModel {
  Ref ref;

  SupervisorViewModel(this.ref);

  void navigateToAccountManagementScreen(BuildContext context) {
    context.pushNamed(AdminAccountmanagementScreen.routeName);
  }

  void navigateToPostsManagementScreen(BuildContext context) {
    context.pushNamed(AdminPostmanagementScreen.routeName);
  }

  void navigateToReportManagementScreen(BuildContext context) {
    context.pushNamed(AdminReportManagementScreen.routeName);
  }
}
