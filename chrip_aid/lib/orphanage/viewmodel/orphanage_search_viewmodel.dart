import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_geocoding/google_geocoding.dart';

final orphanageSearchViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageSearchViewModel(ref));

class OrphanageSearchViewModel extends ChangeNotifier {
  Ref ref;
  late final GoogleMapController mapController;
  final Set<Marker> markers = {};

  OrphanageSearchViewModel(this.ref);

  void getPlaceByName(String name) async {
    var googleGeocoding = GoogleGeocoding(dotenv.get('GOOGLE_MAP_KEY'));
    GeocodingResponse? p = await googleGeocoding.geocoding.get(name, []);

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
      markerId: MarkerId("${markers.length}"),
      position: position,
    ));

    mapController.animateCamera(CameraUpdate.newLatLngZoom(position, 14.0));

    notifyListeners();
  }
}
