import 'package:chrip_aid/orphanage/component/custom_field_padding.dart';
import 'package:chrip_aid/orphanage/component/custom_percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/common/styles/styles.dart';

class CustomProductBox extends ConsumerWidget {
  final String photo;
  final String name;
  final String description;
  final double price;
  final int requestCount;
  final int supportCount;
  final double progress;

  const CustomProductBox(
      {required this.photo,
      required this.name,
      required this.description,
      required this.price,
      required this.requestCount,
      required this.supportCount,
      required this.progress,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = Product(
      photo: photo,
      name: name,
      description: description,
      price: price,
      requestCount: requestCount,
      supportCount: supportCount,
      progress: progress,
    );

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kPaddingMiddleSize, vertical: kPaddingSmallSize),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: Image.asset(
                  product.photo,
                  fit: BoxFit.cover,
                )),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFieldPadding(
                          text: product.name,
                          textSize: 14.0,
                        ),
                        CustomFieldPadding(
                          text: product.description,
                          color: CustomColor.ContentSubColor,
                        ),
                        CustomFieldPadding(
                          text: "가격 : ${product.price}원",
                          color: CustomColor.ContentSubColor,
                        ),
                        CustomFieldPadding(
                          text:
                              '요청 개수: ${product.requestCount}개  후원 개수: ${product.supportCount}개',
                          color: CustomColor.ContentSubColor,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero, // 패딩 설정
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.shopping_cart,
                            size: kIconXSmallSize),
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: 48.0,
                      )
                    ],
                  )
                ],
              ),
              CustomPercentIndicator(progress: product.progress),
            ]),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String photo;
  final String name;
  final String description;
  final double price;
  final int requestCount;
  final int supportCount;
  final double progress;

  Product({
    required this.photo,
    required this.name,
    required this.description,
    required this.price,
    required this.requestCount,
    required this.supportCount,
    required this.progress,
  });
}
