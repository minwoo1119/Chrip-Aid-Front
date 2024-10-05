import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/notice_viewmodel.dart';
import '../model/notice_model.dart';

class NoticePopup extends ConsumerWidget {
  const NoticePopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notices = ref.watch(noticeViewModelProvider);

    return AlertDialog(
      title: const Text("기부금 영수증 안내"),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: notices.length,
          itemBuilder: (context, index) {
            final notice = notices[index];
            return ListTile(
              title: Text(notice.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(notice.content),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // 팝업 닫기
          },
          child: const Text("취소"),
        ),
        TextButton(
          onPressed: () {
            // 동의하고 진행하기
            Navigator.of(context).pop(); // 팝업 닫기
            // 이후 프로세스 진행 가능
          },
          child: const Text("동의하고 진행"),
        ),
      ],
    );
  }
}
