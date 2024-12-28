import 'package:chrip_aid/auth/util/google_map_util.dart';
import 'package:chrip_aid/common/component/custom_dropdown_button.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
import 'package:chrip_aid/orphanage/component/custom_text_field_bar.dart';
import 'package:chrip_aid/orphanage/component/orphanage_info_item.dart';
import 'package:chrip_aid/orphanage/viewmodel/orphanage_search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:chrip_aid/root_tab/view/tab_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class OrphanageMapScreen extends ConsumerStatefulWidget {
  static String get routeName => 'mapPage';

  const OrphanageMapScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OrphanageMapScreen> createState() => _OrphanageMapScreenState();
}

class _OrphanageMapScreenState extends ConsumerState<OrphanageMapScreen> {
  CameraPosition? _initialCameraPosition;
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  final List<Map<String, dynamic>> orphanages = [
    {"orphanage_id": 1, "orphanage_name": "Sunshine Orphanage", "address": "123 Seolleung-ro, Gangnam-gu, Seoul", "phone_number": "010-1111-2222", "photo": "path/to/sunshine_photo.jpg", "name": "홍길동이요옹",'latitude': 37.510015, 'longitude': 127.051582},
    {"orphanage_id": 2, "orphanage_name": "Test Orphanage", "address": "69 Okgyebuk-ro, Gumi-si, Gyeongsangbuk-do", "phone_number": "010-1234-5678", "photo": "path/to/photo.jpg", "name": null,'latitude': 36.1386477769341, 'longitude': 128.424130669144},
    {"orphanage_id": 3, "orphanage_name": "Hope Orphanage", "address": "69 Okgyebuk-ro, Gumi-si, Gyeongsangbuk-do", "phone_number": "010-9876-5432", "photo": "http://www.pajukids.com/img/sec1-img2.jpg", "name": "홍길동이",'latitude': 36.1386477769341, 'longitude': 128.424130669144},
    {"orphanage_id": 4, "orphanage_name": "Dreamland Orphanage", "address": "부산광역시 해운대구 해운대해변로 20", "phone_number": "010-2222-3333", "photo": "path/to/dreamland_photo.jpg", "name": null,'latitude': 35.1622703240721, 'longitude': 129.136882053234},
    {"orphanage_id": 5, "orphanage_name": "Little Stars Home", "address": "대구광역시 중구 공평로 50", "phone_number": "010-3333-4444", "photo": "path/to/little_stars_photo.jpg", "name": null,'latitude': 35.8685911, 'longitude': 128.6004626},
    {"orphanage_id": 6, "orphanage_name": "Rainbow Orphanage", "address": "인천광역시 미추홀구 소성로 30", "phone_number": "010-5555-6666", "photo": "path/to/rainbow_photo.jpg", "name": "김시옹",'latitude': 37.4419449, 'longitude': 126.6702148},
    {"orphanage_id": 7, "orphanage_name": "Safe Haven Orphanage", "address": "대전광역시 유성구 과학로 10", "phone_number": "010-6666-7777", "photo": "path/to/safehaven_photo.jpg", "name": null,'latitude': 36.3763892, 'longitude': 127.3610409},
    {"orphanage_id": 8, "orphanage_name": "Future Hope Orphanage", "address": "울산광역시 남구 삼산로 78", "phone_number": "010-7777-8888", "photo": "path/to/future_hope_photo.jpg", "name": null,'latitude': 35.5371622, 'longitude': 129.3293925},
    {"orphanage_id": 9, "orphanage_name": "Happy Hearts Orphanage", "address": "광주광역시 동구 문화로 100", "phone_number": "010-8888-9999", "photo": "path/to/happy_hearts_photo.jpg", "name": "김시옹요",'latitude': 35.1174067, 'longitude': 126.9494407},
    {"orphanage_id": 10, "orphanage_name": "New Life Orphanage", "address": "제주특별자치도 제주시 한라산로 200", "phone_number": "010-9999-0000", "photo": "path/to/new_life_photo.jpg", "name": null,'latitude': 33.4073649, 'longitude': 126.2563337},
  ];

  @override
  void initState() {
    super.initState();
    _fetchInitialPosition();
    _loadMarkers();
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


  Future<void> _loadMarkers() async {
    for (var orphanage in orphanages) {
      try {
          setState(() {
            markers.add(
              Marker(
                markerId: MarkerId(orphanage['orphanage_id'].toString()),
                position: LatLng(orphanage['latitude'], orphanage['longitude']),
                infoWindow: InfoWindow(
                  title: orphanage['orphanage_name'],
                  snippet: '${orphanage['address']}\nPhone: ${orphanage['phone_number']}',
                ),
              ),
            );
          });

      } catch (e) {
        print("Error locating address: ${orphanage['address']}");
      }
    }
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
              markers: markers,
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
