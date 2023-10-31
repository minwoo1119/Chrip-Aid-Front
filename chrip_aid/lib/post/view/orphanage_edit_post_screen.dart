import 'package:chrip_aid/common/component/custom_text_form_field.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrphanageEditPostScreen extends ConsumerWidget {
  static String get routeName => 'editPost';
  const OrphanageEditPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: "인증글 작성",
      child: Column(
        children: [
          CustomTextFormField(

          )
        ],
      ),
    );
  }
}
