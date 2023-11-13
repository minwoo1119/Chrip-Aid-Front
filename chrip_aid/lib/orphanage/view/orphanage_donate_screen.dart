import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/orphanage/component/custom_donate_box.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/orphanage/viewmodel/orphanage_donate_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrphanageDonateScreen extends ConsumerWidget {
  static String get routeName => "donate";

  const OrphanageDonateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(orphanageDonateViewModelProvider);
    return DetailPageLayout(
      backgroundColor: CustomColor.disabledColor,
      title: "기부내역",
      child: viewModel.state is SuccessState
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.entity.length,
                    itemBuilder: (context, index) {
                      final item = viewModel.entity[index];
                      return CustomDonateBox(
                        orphanageName: item.orphanageName,
                        date: item.date,
                        productName: item.productName,
                        price: item.price,
                        count: item.count,
                        message: item.message,
                      );
                    },
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
