import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Gyeongbuk implements SubRegion {
  pohangsi('포항시'),
  gyeongjusi('경주시'),
  gimcheonsi('김천시'),
  andongsi('안동시'),
  gumisi("구미시"),
  yeongjusi("영주시"),
  yeongcheonsi("영천시"),
  sangjusi("상주시"),
  mungyeongsi("문경시"),
  gyeongsansi("경산시");

  @override
  final String value;

  @override
  MajorRegion get majorRegion => MajorRegion.gyeongbuk;

  const Gyeongbuk(this.value);

  @override
  String toJson() => "${majorRegion.value} ($value)";

  @override
  String toString() => value;
}
