import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Gyeongnam implements SubRegion {
  changwonsi('창원시'),
  jinjusi('진주시'),
  tongyeongsi('통영시'),
  sacheonsi('사천시'),
  gimhaesi("김해시"),
  miryangsi("밀양시"),
  geojesi("거제시"),
  yangsansi("양산시");

  @override
  final String name;

  @override
  MajorRegion get majorRegion => MajorRegion.gyeongnam;

  const Gyeongnam(this.name);

  @override
  String toJson() => "${majorRegion.name} ($name)";

  @override
  String toString() => name;
}
