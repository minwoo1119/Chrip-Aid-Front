import 'package:chrip_aid/auth/model/type/region.dart';
import 'package:chrip_aid/auth/model/type/region/sub_region.dart';
import 'package:chrip_aid/common/component/custom_dropdown_button.dart';
import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/member/model/entity/user_entity.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_entity.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:chrip_aid/orphanage/view/orphanage_detail_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:go_router/go_router.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

final orphanageSearchViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageSearchViewModel(ref));

class OrphanageSearchViewModel extends ChangeNotifier {
  Ref ref;

  late GoogleMapController mapController;
  final Set<Marker> markers = {};

  late final CustomDropdownButtonController<MajorRegion>
      majorRegionDropdownController;
  late final CustomDropdownButtonController<SubRegion>
      subRegionDropdownController;

  late final CustomDropdownButtonController sortDropdownController;

  final panelController = SlidingUpPanelController();
  final searchTextController = TextEditingController();

  late final MemberInfoService _memberInfoService;
  late final OrphanageService _orphanageService;

  final MemberInfoState memberState = MemberInfoState();

  OrphanageListState get orphanageListState =>
      _orphanageService.orphanageListState;

  OrphanageDetailState get orphanageDetailState =>
      _orphanageService.orphanageDetailState;

  UserEntity? get _userInfo => memberState.value as UserEntity?;

  OrphanageEntity? orphanage;

  List<OrphanageEntity> get orphanageList =>
      orphanageListState.value
          ?.where((e) =>
              e.address.contains(subRegionDropdownController.selected.name) &&
              e.address
                  .contains(majorRegionDropdownController.selected.fullName) &&
              e.orphanageName.contains(searchTextController.text))
          .toList() ??
      [];

  OrphanageSearchViewModel(this.ref) {
    _memberInfoService = ref.read(memberInfoServiceProvider);
    _orphanageService = ref.read(orphanageServiceProvider);

    orphanageListState.addListener(notifyListeners);
    orphanageListState.addListener(() {
      if (orphanageListState.isSuccess) _initMarker();
    });

    memberState.addListener(() {
      if (memberState.isSuccess) {
        majorRegionDropdownController.select(
          MajorRegion.values.indexOf(_userInfo!.region.majorRegion),
        );
        subRegionDropdownController.select(
          _userInfo!.region.majorRegion.subTypes.indexOf(
            _userInfo!.region,
          ),
        );
      }
    });

    majorRegionDropdownController = CustomDropdownButtonController(
      MajorRegion.values,
      initIndex: _userInfo == null
          ? 0
          : MajorRegion.values.indexOf(_userInfo!.region.majorRegion),
      onChanged: (_) {
        subRegionDropdownController.items =
            majorRegionDropdownController.selected.subTypes;
        notifyListeners();
      },
    );
    subRegionDropdownController = CustomDropdownButtonController(
      majorRegionDropdownController.selected.subTypes,
      initIndex: _userInfo == null
          ? 0
          : _userInfo!.region.majorRegion.subTypes.indexOf(
              _userInfo!.region,
            ),
      onChanged: (_) => notifyListeners(),
    );
    sortDropdownController = CustomDropdownButtonController(
      ["최신순", "오래된순"],
      onChanged: (_) => notifyListeners(),
    );

    getInfo();
  }

  void getInfo() {
    if (!memberState.isSuccess) {
      memberState.withResponse(_memberInfoService.getMemberInfo());
    }
    _orphanageService.getOrphanageList();
  }

  void onValueChange() => notifyListeners();

  void onPanelExpanded(BuildContext context) {
    panelController.collapse();
    if (orphanage == null) {
      navigateToSearchPage(context);
    } else {
      navigateToDetailPage(context);
    }
  }

  void navigateToSearchPage(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.pushNamed(OrphanageSearchScreen.routeName).then((value) {
      if (value != null) {
        moveCameraToMarker(value.toString());
      }
    });
  }

  void navigateToDetailPage(BuildContext context) {
    _orphanageService.getOrphanageDetail(orphanage!.orphanageId);
    FocusManager.instance.primaryFocus?.unfocus();
    context.pushNamed(OrphanageDetailScreen.routeName);
  }

  void moveCameraToMarker(String id) {
    orphanage =
        orphanageList.where((e) => e.orphanageId.toString() == id).first;
    final marker = markers.where((e) => e.markerId.value == id).first;
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: marker.position, zoom: 14.0),
      ),
    );
    panelController.anchor();
    notifyListeners();
  }

  void _initMarker() async {
    for (var element in orphanageList) {
      _addMarkerByAddress(element);
    }
    notifyListeners();
  }

  void _addMarkerByAddress(OrphanageEntity entity) async {
    var googleGeocoding = GoogleGeocoding(dotenv.get('GOOGLE_MAP_KEY'));
    GeocodingResponse? p =
        await googleGeocoding.geocoding.get(entity.address, []);

    if (p == null) return;

    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: dotenv.get('GOOGLE_MAP_KEY'),
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(
      p.results![0].placeId!,
    );

    final position = LatLng(
      detail.result.geometry!.location.lat,
      detail.result.geometry!.location.lng,
    );

    markers.add(Marker(
      markerId: MarkerId(entity.orphanageId.toString()),
      position: position,
      onTap: () => moveCameraToMarker(entity.orphanageId.toString()),
    ));
  }
}
