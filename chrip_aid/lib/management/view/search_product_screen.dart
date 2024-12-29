import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/management/component/custom_basket_product_box_3.dart';
import 'package:chrip_aid/management/model/service/orphanage_management_service.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/management/model/repository/orphanage_management_repository.dart';

class SearchProductScreen extends ConsumerStatefulWidget {
  final void Function(int) onProductSelected;

  const SearchProductScreen({
    Key? key,
    required this.onProductSelected,
  }) : super(key: key);

  @override
  ConsumerState<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends ConsumerState<SearchProductScreen> {
  List<ProductEntity> filteredProducts = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchInitialProducts();
  }

  Future<void> _fetchInitialProducts() async {
    // 초기 데이터 가져오기
    final orphanageService = ref.read(orphanageManagementServiceProvider);
    final response = await orphanageService.getProductList('');
    if (response.isSuccess) {
      setState(() {
        filteredProducts = response.entity!;
      });
    } else {
      // 에러 처리
      print(response.message);
    }
  }

  Future<void> updateSearchQuery() async {
    final orphanageService = ref.read(orphanageManagementServiceProvider);
    final response = await orphanageService.getProductList(searchQuery);
    if (response.isSuccess) {
      setState(() {
        filteredProducts = response.entity!;
      });
    } else {
      // 에러 처리
      print(response.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "물품 선택",
      titleStyle: kTextContentStyleMedium,
      extendBodyBehindAppBar: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kPaddingSmallSize),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      searchQuery = value; // 검색어를 업데이트만 함
                    },
                    decoration: const InputDecoration(
                      hintText: "검색어를 입력하세요",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: updateSearchQuery, // 검색 아이콘 클릭 시 실행
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: filteredProducts.length,
              padding: const EdgeInsets.all(kPaddingSmallSize),
              itemBuilder: (_, i) => InkWell(
                onTap: () {
                  widget.onProductSelected(i);
                  context.pop();
                },
                child: CustomBasketProductBox3(entity: filteredProducts[i]),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: kPaddingMiddleSize,
                childAspectRatio: 0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
