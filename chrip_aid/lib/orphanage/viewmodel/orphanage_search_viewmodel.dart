import 'package:chrip_aid/common/component/custom_dropdown_button.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_entity.dart';
import 'package:chrip_aid/orphanage/model/service/orphanage_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:go_router/go_router.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_geocoding/google_geocoding.dart';

final orphanageSearchViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageSearchViewModel(ref));

class OrphanageSearchViewModel extends ChangeNotifier {
  Ref ref;
  late GoogleMapController mapController;
  final Set<Marker> markers = {};

  late final CustomDropdownButtonController locationDropdownController;

  late final CustomDropdownButtonController sortDropdownController;

  final panelController = SlidingUpPanelController();
  final searchTextController = TextEditingController();

  late OrphanageState state;

  OrphanageEntity? orphanage;

  List<OrphanageEntity> get orphanageList => OrphanageState.list
      .where((e) =>
          e.address.contains(locationDropdownController.selected) &&
          e.orphanageName.contains(searchTextController.text))
      .toList();

  OrphanageSearchViewModel(this.ref) {
    locationDropdownController = CustomDropdownButtonController(
      ["구미", "대구", "경산", "파주"],
      onChanged: (_) => notifyListeners(),
    );
    sortDropdownController = CustomDropdownButtonController(
      ["최신순", "오래된순"],
      onChanged: (_) => notifyListeners(),
    );
    state = ref.read(orphanageServiceProvider);
    ref.listen(orphanageServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        if (state is NoneState) _initMarker();
        notifyListeners();
      }
    });
  }

  void navigateToSearchPage(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.push("/orphanage/search").then((value) {
      if (value != null) moveCameraToMarker(value.toString());
    });
  }

  void navigateToDetailPage(BuildContext context) {
    ref
        .read(orphanageServiceProvider.notifier)
        .getOrphanageDetail(orphanage!.orphanageId);
    FocusManager.instance.primaryFocus?.unfocus();
    context.pushNamed("detailPage");
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