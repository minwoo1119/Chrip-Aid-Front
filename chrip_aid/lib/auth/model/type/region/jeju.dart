import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Jeju implements SubRegion {
  jejuCity('제주시'),
  seogwipo('서귀포시');

  @override
  MajorRegion get majorRegion => MajorRegion.jeju;

  @override
  final String name;

  const Jeju(this.name);

  @override
  String toJson() => "${majorRegion.name} ($name)";

  @override
  String toString() => name;
}
