import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/management/component/custom_basket_product_box_3.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchProductScreen extends StatelessWidget {
  final List<ProductEntity> products;
  final void Function(int) onProductSelected;

  const SearchProductScreen(
      {Key? key, required this.products, required this.onProductSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "물품 선택",
      titleStyle: kTextContentStyleMedium,
      extendBodyBehindAppBar: false,
      child: GridView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.all(kPaddingSmallSize),
        itemBuilder: (_, i) => InkWell(
          onTap: () {
            onProductSelected(i);
            context.pop();
          },
          child: CustomBasketProductBox3(entity: products[i]),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: kPaddingMiddleSize,
          childAspectRatio: 0.7,
        ),
      ),
    );
  }
}
