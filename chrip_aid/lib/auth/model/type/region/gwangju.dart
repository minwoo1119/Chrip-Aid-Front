import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Gwangju implements SubRegion {
  donggu('동구'),
  seogu('서구'),
  namgu('남구'),
  bukgu('북구'),
  gwangsangu('광산구');

  @override
  final String value;

  @override
  MajorRegion get majorRegion => MajorRegion.gwangju;

  const Gwangju(this.value);

  @override
  String toJson() => "${majorRegion.value} ($value)";

  @override
  String toString() => value;
}
