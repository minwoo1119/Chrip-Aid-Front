import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Daejeon implements SubRegion {
  donggu('동구'),
  junggu('중구'),
  seogu('서구'),
  yuseonggu('유성구'),
  daedeokgu('대덕구');

  @override
  final String name;

  @override
  MajorRegion get majorRegion => MajorRegion.daejeon;

  const Daejeon(this.name);

  @override
  String toJson() => "${majorRegion.name} ($name)";

  @override
  String toString() => name;
}
