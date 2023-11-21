import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
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
    final viewModel = ref.watch(orphanageDonateViewModelProvider)..getInfo();
    return DetailPageLayout(
        backgroundColor: CustomColor.disabledColor,
        title: "기부내역",
        child: ValueStateListener(
          state: viewModel.state,
          successBuilder: (_, state) => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.value!.length,
                  itemBuilder: (context, index) {
                    final item = state.value![index];
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
          ),
        ));
  }
}
