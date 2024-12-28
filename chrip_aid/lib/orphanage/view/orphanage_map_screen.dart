import 'package:chrip_aid/auth/util/google_map_util.dart';
import 'package:chrip_aid/common/component/custom_dropdown_button.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
import 'package:chrip_aid/orphanage/component/custom_text_field_bar.dart';
import 'package:chrip_aid/orphanage/component/orphanage_info_item.dart';
import 'package:chrip_aid/orphanage/viewmodel/orphanage_search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrphanageMapScreen extends ConsumerStatefulWidget {
  static String get routeName => 'mapPage';

  const OrphanageMapScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OrphanageMapScreen> createState() => _OrphanageMapScreenState();
}

class _OrphanageMapScreenState extends ConsumerState<OrphanageMapScreen> {
  CameraPosition? _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _fetchInitialPosition();
  }

  Future<void> _fetchInitialPosition() async {
    final initialLatLng = await getInitialLocation();
    setState(() {
      _initialCameraPosition = CameraPosition(
        target: initialLatLng,
        zoom: 15.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(orphanageSearchViewModelProvider)..getInfo();
    if (_initialCameraPosition == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return DefaultLayout(
      child: Stack(
        children: [
          GestureDetector(
            child: GoogleMap(
              onTap: (_) => viewModel.panelController.collapse(),
              initialCameraPosition: _initialCameraPosition!,
              mapType: MapType.normal,
              onMapCreated: (controller) =>
                  viewModel.mapController = controller,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              markers: viewModel.markers,
            ),
          ),
          const _OrphanageSearchUI(),
          const _SlidingUpPanel(),
        ],
      ),
    );
  }
}

class _OrphanageSearchUI extends ConsumerWidget {
  const _OrphanageSearchUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(orphanageSearchViewModelProvider);
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: kPaddingMiddleSize),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: kLayoutGutter),
            child: Row(
              children: [
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: kLayoutMargin),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () => viewModel.navigateToSearchPage(context),
                    child: CustomDropdownButton(
                      viewModel.majorRegionDropdownController,
                      leading: Icons.location_on,
                    ),
                  ),
                ),
                const SizedBox(width: kLayoutMargin),
                Expanded(
                  flex: 4,
                  child: Hero(
                    tag: "Search Bar",
                    child: Material(
                      color: Colors.transparent,
                      child: CustomTextFieldBar(
                        controller: viewModel.searchTextController,
                        onTap: () => viewModel.navigateToSearchPage(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SlidingUpPanel extends ConsumerWidget {
  const _SlidingUpPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(orphanageSearchViewModelProvider);
    return SlidingUpPanelWidget(
      anchor: 0.43,
      elevation: 8.0,
      controlHeight: kPaddingSmallSize + kPaddingLargeSize + 5,
      panelController: viewModel.panelController,
      onStatusChanged: (status) {
        if (status == SlidingUpPanelStatus.expanded) {
          viewModel.onPanelExpanded(context);
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
                  const SizedBox(height: kPaddingSmallSize),
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
                  const SizedBox(height: kPaddingLargeSize),
                  ValueStateListener(
                    state: viewModel.orphanageState,
                    successBuilder: (_, state) => OrphanageInfoItem(
                      entity: state.value!.first,
                      onTap: () => viewModel.navigateToDetailPage(
                        context,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
