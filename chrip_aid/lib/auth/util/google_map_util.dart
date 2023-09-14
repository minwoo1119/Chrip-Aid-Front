import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_webservice/places.dart';

const CameraPosition initialPosition = CameraPosition(
    target: LatLng(36.30808077893056, 127.66468472778797), zoom: 15.0);