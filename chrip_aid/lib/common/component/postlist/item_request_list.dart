import 'package:chrip_aid/admin/viewmodel/admin_postmanagement_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemRequestList extends ConsumerWidget {
  final String count;
  final String supported_count;
  final String state;
  final String message;

  const ItemRequestList({
    super.key,
    required this.count,
    required this.supported_count,
    required this.state,
    required this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(adminPostManagementViewModelProvider);
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.green,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "상품명",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  "총 ${supported_count}/${count}",
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await viewModel.deleteRequestPost(2);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('사용자가 삭제되었습니다.')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('사용자 삭제 중 오류가 발생했습니다: $e')),
                      );
                    }
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.delete),
                      Text("삭제"),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
