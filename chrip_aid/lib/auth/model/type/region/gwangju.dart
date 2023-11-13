import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Gwangju implements SubRegion {
  donggu('동구'),
  seogu('서구'),
  namgu('남구'),
  bukgu('북구'),
  gwangsangu('광산구');

  @override
  final String name;

  @override
  MajorRegion get majorRegion => MajorRegion.gwangju;

  const Gwangju(this.name);

  @override
  String toJson() => "${majorRegion.name} ($name)";

  @override
  String toString() => name;
}
