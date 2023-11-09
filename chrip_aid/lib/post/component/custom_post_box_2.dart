import 'package:card_swiper/card_swiper.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/orphanage/component/expandable_product_name.dart';
import 'package:chrip_aid/orphanage/component/title_content_box.dart';
import 'package:flutter/material.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class Post {
  final int reviewId;
  final String title;
  final String content;
  final String photo;
  final String date;
  final String name;
  final String orphanageName;
  final List<String> productNames;

  Post({
    required this.reviewId,
    required this.title,
    required this.content,
    required this.photo,
    required this.date,
    required this.name,
    required this.orphanageName,
    required this.productNames,
  });
}

class CustomPostBox2 extends StatelessWidget {
  final int reviewId;
  final String title;
  final String content;
  final List<String> photos;
  final String date;
  final String name;
  final String orphanageName;
  final List<String> productNames;

  const CustomPostBox2({
    super.key,
    required this.reviewId,
    required this.title,
    required this.content,
    required this.photos,
    required this.date,
    required this.name,
    required this.orphanageName,
    required this.productNames,
  });

  @override
  Widget build(BuildContext context) {
    final parsedDate = DateTime.parse(date);
    final formattedDate = DateFormat('yyyy년 M월 d일 H시 m분').format(parsedDate);

    return Column(
      children: [
        const Divider(
          color: CustomColor.disabledColor,
          height: 2.0,
          thickness: 5.0,
        ),
        Container(
          color: CustomColor.backgroundMainColor,
          padding: const EdgeInsets.symmetric(
              horizontal: kPaddingMiddleSize, vertical: kPaddingMiddleSize),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "[$orphanageName] $title",
                      style: kTextContentStyleMedium,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: kTextContentStyleSmall,
                            ),
                            Text(formattedDate,
                                style: kTextContentStyleSmall.copyWith(
                                  color: CustomColor.contentSubColor,
                                )),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ClipRRect(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: _DesignedSwiper(
                            itemCount: photos.length,
                            itemBuilder: (_, index) => InkWell(
                              onTap: () => showDialog(
                                useRootNavigator: true,
                                context: context,
                                builder: (context) => DefaultLayout(
                                  extendBodyBehindAppBar: true,
                                  appbarColor: Colors.transparent,
                                  leading: IconButton(
                                    onPressed: context.pop,
                                    icon: const Icon(Icons.close),
                                    color: CustomColor.textReverseColor,
                                    splashRadius: kIconSmallSize,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                  title: "",
                                  child: PhotoView(
                                    imageProvider: NetworkImage(photos[index]),
                                  ),
                                ),
                              ),
                              child: Image.network(
                                photos[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(height: 10),
                                    TitleContentBox(
                                      reason: content,
                                    ),
                                    const SizedBox(height: 10),
                                    ExpandableProductNames(
                                      productNames: productNames,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DesignedSwiper extends Swiper {
  static const Color _color = CustomColor.textReverseColor;
  static const Color _disableColor = Color(0x55ffffff);

  const _DesignedSwiper({
    required super.itemCount,
    super.itemBuilder,
  }) : super(
          pagination: const SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
              color: _disableColor,
              activeColor: _color,
            ),
          ),
          loop: false,
        );
}
