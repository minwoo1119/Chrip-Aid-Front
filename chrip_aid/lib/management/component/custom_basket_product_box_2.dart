import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/orphanage/component/custom_field_padding.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomBasketProductBox2 extends StatefulWidget {
  final String productName;
  final int count;
  final int price;
  final String photo;
  final Function(int) onCountUpdate;
  final Function() onDelete;

  const CustomBasketProductBox2({
    required this.productName,
    required this.count,
    required this.price,
    required this.onCountUpdate,
    required this.onDelete,
    required this.photo,
    super.key,
  });

  @override
  CustomBasketProductBox2State createState() => CustomBasketProductBox2State();
}

class CustomBasketProductBox2State extends State<CustomBasketProductBox2> {
  late int count;

  @override
  void initState() {
    count = widget.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(color: Colors.grey),
            child: Image.network(widget.photo, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: kPaddingSmallSize),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomFieldPadding(
                      text: widget.productName,
                      textSize: kTextMediumSize,
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onDelete,
                    icon: const Icon(Icons.delete, size: kIconSmallSize),
                    splashRadius: kIconSmallSize,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: kPaddingMiddleSize),
              Row(
                children: [
                  /** 수량 감소 버튼 **/
                  RawMaterialButton(
                    onPressed: count == 1
                        ? null
                        : () {
                            setState(() {
                              count--;
                              widget.onCountUpdate(count);
                            });
                          },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: const BorderSide(
                        color: Colors.black12,
                        width: 2.0,
                      ),
                    ),
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    fillColor: count == 1 ? CustomColor.disabledColor : null,
                    constraints: const BoxConstraints(
                      minWidth: 35.0,
                      minHeight: 35.0,
                    ),
                    child: Icon(
                      Icons.remove,
                      color: count == 1 ? Colors.grey : Colors.black,
                      size: kIconSmallSize,
                    ),
                  ),
                  /** 수량 **/
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kPaddingSmallSize,
                    ),
                    child: Text('$count', style: kTextContentStyleMedium),
                  ),
                  /** 수량 증가 버튼 **/
                  RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        count++;
                        widget.onCountUpdate(count);
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: const BorderSide(
                        color: Colors.black12,
                        width: 2.0,
                      ),
                    ),
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    constraints: const BoxConstraints(
                      minWidth: 35.0,
                      minHeight: 35.0,
                    ),
                    child: const Icon(Icons.add, size: kIconSmallSize),
                  ),
                  Expanded(child: Container()),
                  /** 가격 **/
                  Text(
                    "${NumberFormat.decimalPattern().format(count * widget.price)}원",
                    style: kTextContentStyleMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
