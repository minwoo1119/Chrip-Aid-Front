import 'package:chrip_aid/auth/model/type/region.dart';
import 'package:chrip_aid/auth/model/type/region/sub_region.dart';
import 'package:chrip_aid/common/component/custom_dropdown_button.dart';
import 'package:chrip_aid/common/state/state.dart';
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

  late MemberInfoState authState;

  UserEntity? get userInfo => authState is MemberInfoStateSuccess
      ? (authState as MemberInfoStateSuccess).data as UserEntity
      : null;

  late OrphanageState orphanageState;

  OrphanageEntity? orphanage;

  List<OrphanageEntity> get orphanageList => OrphanageState.list
      .where((e) =>
          e.address.contains(subRegionDropdownController.selected.value) &&
          e.address.contains(majorRegionDropdownController.selected.value) &&
          e.orphanageName.contains(searchTextController.text))
      .toList();

  OrphanageSearchViewModel(this.ref) {
    orphanageState = ref.read(orphanageServiceProvider);
    ref.listen(orphanageServiceProvider, (previous, next) {
      if (previous != next) {
        orphanageState = next;
        if (orphanageState is NoneState) _initMarker();
        notifyListeners();
      }
    });
    authState = ref.read(memberInfoServiceProvider);
    ref.listen(memberInfoServiceProvider, (previous, next) {
      if (previous != next) {
        authState = next;
        notifyListeners();
      }
    });

    majorRegionDropdownController = CustomDropdownButtonController(
      MajorRegion.values,
      initIndex: MajorRegion.values.indexOf(userInfo!.region.majorRegion),
      onChanged: (_) {
        subRegionDropdownController.items =
            majorRegionDropdownController.selected.subTypes;
        notifyListeners();
      },
    );
    subRegionDropdownController = CustomDropdownButtonController(
      majorRegionDropdownController.selected.subTypes,
      initIndex: userInfo!.region.majorRegion.subTypes.indexOf(
        userInfo!.region,
      ),
      onChanged: (_) => notifyListeners(),
    );
    sortDropdownController = CustomDropdownButtonController(
      ["최신순", "오래된순"],
      onChanged: (_) => notifyListeners(),
    );
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
    ref
        .read(orphanageServiceProvider.notifier)
        .getOrphanageDetail(orphanage!.orphanageId);
    FocusManager.instance.primaryFocus?.unfocus();
    context.pushNamed(OrphanageDetailScreen.routeName);
  }

  void moveCameraToMarker(String id) {
    orphanage = OrphanageState.list.where((e) => e.orphanageId == id).first;
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
    for (var element in OrphanageState.list) {
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
      markerId: MarkerId(entity.orphanageId),
      position: position,
      onTap: () => moveCameraToMarker(entity.orphanageId),
    ));
  }
}
