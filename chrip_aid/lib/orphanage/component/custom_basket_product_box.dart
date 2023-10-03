import 'package:chrip_aid/orphanage/component/custom_field_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:intl/intl.dart';

class Product {
  final int basketProductId;
  final String productName;
  final int count;
  final int price;
  final String orphanageName;

  Product({
    required this.basketProductId,
    required this.productName,
    required this.count,
    required this.price,
    required this.orphanageName,
  });
}

class CustomBasketProductBox extends ConsumerStatefulWidget {
  final int basketProductId;
  final String productName;
  final int count;
  final int price;
  final String orphanageName;

  const CustomBasketProductBox(
      {required this.basketProductId,
      required this.productName,
      required this.count,
      required this.price,
      required this.orphanageName,
      super.key});

  @override
  CustomBasketProductBoxState createState() => CustomBasketProductBoxState();
}

class CustomBasketProductBoxState
    extends ConsumerState<CustomBasketProductBox> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    const String photo = 'assets/image/choco_pie.jpg';
    final product = Product(
      basketProductId: widget.basketProductId,
      productName: widget.productName,
      count: widget.count,
      price: widget.price,
      orphanageName: widget.orphanageName,
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
                  photo,
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
                          text: product.productName,
                          textSize: 14.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Row(
                  children: [
                    /** 수량 감소 버튼 **/
                    RawMaterialButton(
                      onPressed: counter == 1
                          ? null
                          : () {
                              setState(() {
                                counter--;
                              });
                            },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side:
                            const BorderSide(color: Colors.black12, width: 2.0),
                      ),
                      elevation: 0.0,
                      highlightElevation: 0.0,
                      fillColor:
                          counter == 1 ? CustomColor.disabledColor : null,
                      constraints: const BoxConstraints(
                        minWidth: 45.0,
                        minHeight: 45.0,
                      ),
                      child: Icon(
                        Icons.remove,
                        color: counter == 1 ? Colors.grey : Colors.black,
                      ),
                    ),
                    /** 수량 **/
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPaddingSmallSize),
                      child: Text('$counter', style: kTextContentStyleMedium),
                    ),
                    /** 수량 증가 버튼 **/
                    RawMaterialButton(
                      onPressed: () {
                        setState(() {
                          counter++;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side:
                            const BorderSide(color: Colors.black12, width: 2.0),
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
                            padding:
                                const EdgeInsets.only(right: kPaddingMiniSize),
                            child: Text(
                              "${NumberFormat.decimalPattern().format(counter * product.price)}원",
                              style: kTextContentStyleMedium.copyWith(
                                  //color: CustomColor.ContentSubColor
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // 버튼을 눌렀을 때 수행할 동작
                },
                child: const Padding(
                  padding: EdgeInsets.all(0.0), // 여백 없애기
                  child: Icon(
                    Icons.close,
                    size: kIconXSmallSize,
                  ),
                ),
              ),
              const SizedBox(
                height: 70.0,
              ),
            ],
          )
        ],
      ),
    );
  }
}
