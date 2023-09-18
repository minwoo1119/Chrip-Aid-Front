import 'package:chrip_aid/common/component/custom_dropdown_button.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/orphanage/component/custom_text_field_bar.dart';
import 'package:chrip_aid/orphanage/component/orphanage_info_item.dart';
import 'package:chrip_aid/orphanage/viewmodel/orphanage_search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OrphanageSearchScreen extends ConsumerWidget {
  const OrphanageSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(orphanageSearchViewModelProvider);
    return DefaultLayout(
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: kLayoutMargin),
          child: Column(
            children: [
              const SizedBox(height: kPaddingMiddleSize),
              Row(
                children: [
                  IconButton(
                    onPressed: context.pop,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: CustomColor.mainColor,
                      size: kIconMainSize,
                    ),
                    splashRadius: kIconMainSize / 2,
                    padding: const EdgeInsets.only(right: kPaddingSmallSize),
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: kPaddingSmallSize),
                  Expanded(
                    child: Hero(
                      tag: "Search Bar",
                      child: Material(
                        child: CustomTextFieldBar(
                          controller: viewModel.searchTextController,
                          onChanged: (_) => viewModel.notifyListeners(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kPaddingMiddleSize),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: kTextMediumSize * 2,
                      child: CustomDropdownButton(
                        viewModel.locationDropdownController,
                        leading: Icons.location_on,
                      ),
                    ),
                  ),
                  const SizedBox(width: kLayoutGutter),
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      height: kTextMediumSize * 2,
                      child: CustomDropdownButton(
                        viewModel.sortDropdownController,
                        action: Icons.arrow_drop_down,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kPaddingMiddleSize),
              Expanded(
                child: ListView.separated(
                  itemCount: viewModel.orphanageList.length,
                  itemBuilder: (context, i) => OrphanageInfoItem(
                    entity: viewModel.orphanageList[i],
                    onTap: () => context.pop(
                      viewModel.orphanageList[i].orphanageId,
                    ),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(
                    height: kPaddingMiddleSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
