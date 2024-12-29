import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<LatLng> getInitialLocation() async {
  try {
    // IP API를 사용하여 위치 데이터 가져오기
    final response = await http.get(Uri.parse('http://ip-api.com/json/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final latitude = data['lat'];
      final longitude = data['lon'];

      print('IP 기반 위치: $latitude, $longitude');
      return LatLng(latitude, longitude);
    } else {
      print('IP API 호출 실패. 기본 위치 반환.');
      // API 호출 실패 시 기본 위치 반환
      return const LatLng(36.30808077893056, 127.66468472778797);
    }
  } catch (e) {
    print('예외 발생: $e');
    // 예외 발생 시 기본 위치 반환
    return const LatLng(36.30808077893056, 127.66468472778797);
  }
}
const CameraPosition initialPosition = CameraPosition(
    target: LatLng(36.30808077893056, 127.66468472778797), zoom: 15.0);