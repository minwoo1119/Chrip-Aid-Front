import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Jeju implements SubRegion {
  jejuCity('제주시'),
  seogwipo('서귀포시');

  @override
  MajorRegion get majorRegion => MajorRegion.jeju;

  @override
  final String value;

  const Jeju(this.value);

  @override
  String toJson() => "${majorRegion.value} ($value)";

  @override
  String toString() => value;
}
