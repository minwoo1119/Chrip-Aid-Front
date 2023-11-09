import 'package:chrip_aid/orphanage/component/expandable_product_name.dart';
import 'package:chrip_aid/orphanage/component/title_content_box.dart';
import 'package:flutter/material.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:intl/intl.dart';

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

class CustomPostBox extends StatelessWidget {
  final int reviewId;
  final String title;
  final String content;
  final String photo;
  final String date;
  final String name;
  final String orphanageName;
  final List<String> productNames;

  const CustomPostBox({
    super.key,
    required this.reviewId,
    required this.title,
    required this.content,
    required this.photo,
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
                        child: Image.network(
                          photo,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                                        productNames: productNames),
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
