import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class AdminScreen extends ConsumerWidget {
  static String get routeName => 'supervisor';

  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('관리자 페이지'),
      ),
    );
  }
}
