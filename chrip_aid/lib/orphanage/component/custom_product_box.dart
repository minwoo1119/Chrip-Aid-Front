import 'package:chrip_aid/orphanage/component/custom_field_padding.dart';
import 'package:chrip_aid/orphanage/component/custom_percent_indicator.dart';
import 'package:chrip_aid/orphanage/viewmodel/orphanage_basket_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:intl/intl.dart';
import '../viewmodel/orphange_detail_viewmodel.dart';

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

class CustomProductBox extends ConsumerWidget {
  final int requiredId;
  final String photo;
  final String name;
  final String description;
  final int price;
  final int requestCount;
  final int supportCount;
  final double progress;

  const CustomProductBox(
      {required this.requiredId,
      required this.photo,
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
                      CustomBottomSheet(
                        requestId: product.requiredId,
                        name: product.name,
                        price: product.price,
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

class CustomBottomSheet extends ConsumerStatefulWidget {
  final String name;
  final int requestId;
  final int price;

  const CustomBottomSheet(
      {required this.requestId,
      required this.name,
      required this.price,
      super.key});

  @override
  CustomBottomSheetState createState() => CustomBottomSheetState();
}

// 장바구니 BottomSheet
class CustomBottomSheetState extends ConsumerState<CustomBottomSheet> {
  int _counter = 1;

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(orphanageBasketViewModelProvider);
    final String name = widget.name;
    final int price = widget.price;
    return IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: const Icon(Icons.shopping_cart, size: kIconXSmallSize),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext buildContext, StateSetter bottomState) {
                  return SizedBox(
                    height: 230,
                    child: Container(
                      margin: const EdgeInsets.only(
                          bottom: kPaddingSmallSize, left: kPaddingLargeSize, right: kPaddingLargeSize),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /** Bottom Sheet 탭 닫기 아이콘 **/
                          IconButton(
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                          /** 상품 이름 **/
                          Padding(
                            padding:
                                const EdgeInsets.only(left: kPaddingSmallSize),
                            child: Row(
                              children: [
                                Text(
                                  name,
                                  style: kTextContentStyleSmall,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Flexible(
                            child: Row(
                              children: [
                                /** 수량 감소 버튼 **/
                                RawMaterialButton(
                                  onPressed: _counter == 1
                                      ? null
                                      : () {
                                          bottomState(() {
                                            setState(() {
                                              _counter--;
                                            });
                                          });
                                        },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: const BorderSide(
                                        color: Colors.black12, width: 2.0),
                                  ),
                                  elevation: 0.0,
                                  highlightElevation: 0.0,
                                  fillColor: _counter == 1
                                      ? CustomColor.disabledColor
                                      : null,
                                  constraints: const BoxConstraints(
                                    minWidth: 45.0,
                                    minHeight: 45.0,
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: _counter == 1
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                                /** 수량 **/
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kPaddingSmallSize),
                                  child: Text('$_counter',
                                      style: kTextContentStyleMedium),
                                ),
                                /** 수량 증가 버튼 **/
                                RawMaterialButton(
                                  onPressed: () {
                                    bottomState(() {
                                      setState(() {
                                        _counter++;
                                      });
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: const BorderSide(
                                        color: Colors.black12, width: 2.0),
                                  ),
                                  elevation: 0.0,
                                  highlightElevation: 0.0,
                                  constraints: const BoxConstraints(
                                    minWidth: 45.0,
                                    minHeight: 45.0,
                                  ),
                                  child: const Icon(Icons.add),
                                ),
                                /** 가격 **/
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: kPaddingMiniSize),
                                        child: Text(
                                          "${NumberFormat.decimalPattern().format(_counter * price)}원",
                                          style: kTextContentStyleMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          /** 장바구니 담기 버튼 **/
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewModel.addOrUpdateBasket(
                                        widget.requestId, _counter);
                                    setState(() {
                                      _counter = 1; // _counter 변수를 1로 초기화
                                    });
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: kPaddingMiddleSize),
                                  ),
                                  child: const Text("장바구니 담기",
                                      style: kTextReverseStyleMiddle),
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
            },
          );
        });
  }
}
