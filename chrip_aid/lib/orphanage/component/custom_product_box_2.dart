import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/orphanage/component/custom_field_padding.dart';
import 'package:chrip_aid/orphanage/component/custom_percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Product {
  final int requiredId;
  final String photo;
  final String name;
  final String description;
  final int price;
  final int requestCount;
  final int supportCount;
  final double progress;

  Product({
    required this.requiredId,
    required this.photo,
    required this.name,
    required this.description,
    required this.price,
    required this.requestCount,
    required this.supportCount,
    required this.progress,
  });
}

class CustomProductBox2 extends ConsumerWidget {
  final int requiredId;
  final String photo;
  final String name;
  final String description;
  final int price;
  final int requestCount;
  final int supportCount;
  final double progress;

  const CustomProductBox2({
    required this.requiredId,
    required this.photo,
    required this.name,
    required this.description,
    required this.price,
    required this.requestCount,
    required this.supportCount,
    required this.progress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = Product(
      requiredId: requiredId,
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
        horizontal: kPaddingMiddleSize,
        vertical: kPaddingSmallSize,
      ),
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
              child: Image.network(product.photo, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CustomFieldPadding(
                                  text: product.name,
                                  textSize: 14.0,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete,
                                  size: kIconXSmallSize,
                                ),
                                splashRadius: kIconSmallSize,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                          CustomFieldPadding(
                            text: product.description,
                            color: CustomColor.contentSubColor,
                          ),
                          CustomFieldPadding(
                            text: "가격 : ${product.price}원",
                            color: CustomColor.contentSubColor,
                          ),
                          CustomFieldPadding(
                            text: '요청 개수: ${product.requestCount}개  '
                                '후원 개수: ${product.supportCount}개',
                            color: CustomColor.contentSubColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CustomPercentIndicator(progress: product.progress),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
