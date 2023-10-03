import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/orphanage/component/custom_basket_product_box.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/orphanage/viewmodel/orphanage_basket_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrphanageBasketScreen extends ConsumerStatefulWidget {
  static String get routeName => 'Basket';

  const OrphanageBasketScreen({super.key});

  @override
  OrphanageCartScreenState createState() => OrphanageCartScreenState();
}

class OrphanageCartScreenState extends ConsumerState<OrphanageBasketScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(orphanageBasketViewModelProvider);
    return DetailPageLayout(
        title: "장바구니",
        child: Column(
          children: [
            CustomBasketProductBox(
                basketProductId: viewModel.entity.basketProductId,
                productName: viewModel.entity.productName,
                count: viewModel.entity.count,
                price: viewModel.entity.price,
                orphanageName: viewModel.entity.orphanageName),
            CustomBasketProductBox(
                basketProductId: viewModel.entity.basketProductId,
                productName: viewModel.entity.productName,
                count: viewModel.entity.count,
                price: viewModel.entity.price,
                orphanageName: viewModel.entity.orphanageName),
            CustomBasketProductBox(
                basketProductId: viewModel.entity.basketProductId,
                productName: viewModel.entity.productName,
                count: viewModel.entity.count,
                price: viewModel.entity.price,
                orphanageName: viewModel.entity.orphanageName),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(kPaddingMiddleSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Row(
                      children: [
                        Text(
                          "합계",
                          style: kTextContentStyleMedium,
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "원",
                              style: kTextContentStyleMedium,
                            )
                          ],
                        ))
                      ],
                    ),
                    const SizedBox(height: kPaddingMiddleSize,),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: kPaddingMiddleSize)),
                                child: const Text(
                                  "구매하기",
                                  style: kTextReverseStyleMiddle,
                                ))),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
