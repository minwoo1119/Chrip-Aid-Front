import 'package:chrip_aid/admin/viewmodel/admin_postmanagement_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomPostList extends StatefulWidget {
  final String title;
  final String content;
  final String writtenAt;
  final String nickname;
  final int id;
  final String postType;
  final VoidCallback? onTap;

  const CustomPostList({
    Key? key,
    required this.title,
    required this.content,
    required this.writtenAt,
    required this.nickname,
    required this.id,
    required this.postType,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomPostList> createState() => _CustomPostListState();
}

class _CustomPostListState extends State<CustomPostList> {
  Future<void> _handleDeletePost(BuildContext context, WidgetRef ref) async {
    final viewModel = ref.read(adminPostManagementViewModelProvider);

    try {
      if (widget.postType == "reservation") {
        await viewModel.deleteReservationPost(widget.id);
      } else if (widget.postType == "request") {
        await viewModel.deleteRequestPost(widget.id);
      } else if (widget.postType == "review") {
        await viewModel.deleteThanksPost(widget.id);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('무언가 잘못되었습니다.')),
        );
        return;
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사용자가 삭제되었습니다.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('사용자 삭제 중 오류가 발생했습니다: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return GestureDetector(
          onTap: widget.onTap,
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
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.content,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      widget.writtenAt,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.nickname,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => _handleDeletePost(context, ref),
                      child: Row(
                        children: const [
                          Icon(Icons.delete),
                          Text("삭제"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
