import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Daejeon implements SubRegion {
  donggu('동구'),
  junggu('중구'),
  seogu('서구'),
  yuseonggu('유성구'),
  daedeokgu('대덕구');

  @override
  final String value;

  @override
  MajorRegion get majorRegion => MajorRegion.daejeon;

  const Daejeon(this.value);

  @override
  String toJson() => "${majorRegion.value} ($value)";

  @override
  String toString() => value;
}
