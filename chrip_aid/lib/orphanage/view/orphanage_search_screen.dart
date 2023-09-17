import 'package:chrip_aid/auth/util/google_map_util.dart';
import 'package:chrip_aid/common/component/custom_dropdown_button.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/orphanage/component/orphanage_info_item.dart';
import 'package:chrip_aid/orphanage/viewmodel/orphanage_search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrphanageSearchScreen extends ConsumerStatefulWidget {
  const OrphanageSearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OrphanageSearchScreen> createState() =>
      _OrphanageSearchScreenState();
}

class _OrphanageSearchScreenState extends ConsumerState<OrphanageSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(orphanageSearchViewModelProvider);
    return DefaultLayout(
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.moveCameraToMarker("1"),
      ),
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialPosition,
            mapType: MapType.normal,
            onMapCreated: (controller) => viewModel.mapController = controller,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            markers: viewModel.markers,
          ),
          const _OrphanageSearchUI(),
          SlidingUpPanelWidget(
            anchor: 0.43,
            elevation: 8.0,
            controlHeight: 25.0,
            panelController: viewModel.panelController,
            enableOnTap: viewModel.orphanage != null,
            onStatusChanged: (status) {
              if (status == SlidingUpPanelStatus.expanded) {
                viewModel.navigateToDetailPage(context);
                viewModel.panelController.anchor();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kBorderRadiusSize),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: kLayoutGutter),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              kBorderRadiusSize,
                            ),
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (viewModel.orphanage != null)
                          OrphanageInfoItem(
                            entity: viewModel.orphanage!,
                            onTap: () => viewModel.navigateToDetailPage(
                              context,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrphanageSearchUI extends ConsumerWidget {
  const _OrphanageSearchUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(orphanageSearchViewModelProvider);
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: kLayoutGutter),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomDropdownButton(
                    viewModel.dropdownController,
                    leading: Icons.location_on,
                  ),
                ),
                const SizedBox(width: kLayoutMargin),
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: 30.0,
                    child: CustomDropdownButton(
                      viewModel.dropdownController,
                      action: Icons.arrow_drop_down,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
