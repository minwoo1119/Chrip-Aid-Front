import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/orphanage/component/custom_basket_product_box.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/orphanage/viewmodel/orphanage_basket_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class OrphanageBasketScreen extends ConsumerStatefulWidget {
  static String get routeName => 'basket';

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
      child: viewModel.state is SuccessState
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.entity.length,
                    itemBuilder: (context, index) {
                      final item = viewModel.entity[index];
                      return CustomBasketProductBox(
                          basketProductId: item.basketProductId,
                          productName: item.productName,
                          count: item.count,
                          price: item.price,
                          orphanageName: item.orphanageName,
                          photo: item.productPhoto,
                          onCountUpdate: (int updatedCount) {
                            viewModel.updateBasket(
                                updatedCount, item.requestId);
                          },
                          deleteBasket: () {
                            viewModel.deleteBasket(item.requestId);
                          });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(kPaddingMiddleSize),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "합계",
                            style: kTextContentStyleMedium,
                          ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${NumberFormat.decimalPattern().format(viewModel.total)} 원",
                                style: kTextContentStyleMedium,
                              )
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: kPaddingMiddleSize,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              // TODO : add function (navigate to payment page)
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  vertical: kPaddingMiddleSize,
                                ),
                              ),
                              child: const Text(
                                "구매하기",
                                style: kTextReverseStyleMiddle,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
