import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/post/component/custom_post_box_2.dart';
import 'package:chrip_aid/post/model/entity/get_posts_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailScreen extends ConsumerWidget {
  static String get routeName => 'postDetail';
  final GetPostsEntity entity;

  const PostDetailScreen(this.entity, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DetailPageLayout(
      appBarBackgroundColor: CustomColor.backgroundMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      extendBodyBehindAppBar: false,
      title: "인증글",
      child: CustomPostBox2(
        reviewId: entity.reviewId,
        title: entity.title,
        content: entity.content,
        date: entity.date,
        name: entity.name,
        orphanageName: entity.orphanageName,
        productNames: entity.productNames,
        photos: entity.photo,
      ),
    );
  }
}
