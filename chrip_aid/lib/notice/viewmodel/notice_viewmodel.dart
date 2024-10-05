import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/notice_model.dart';

final noticeViewModelProvider = StateNotifierProvider<NoticeViewModel, List<NoticeModel>>((ref) {
  return NoticeViewModel();
});

class NoticeViewModel extends StateNotifier<List<NoticeModel>> {
  NoticeViewModel() : super([]);

  void addNotice(NoticeModel notice) {
    state = [...state, notice];
  }

  void clearNotices() {
    state = [];
  }
}
