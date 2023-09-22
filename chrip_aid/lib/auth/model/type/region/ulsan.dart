import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Ulsan implements SubRegion {
  junggu('중구'),
  namgu('남구'),
  donggu('동구'),
  bukgu('북구'),
  uljugun('울주군');

  @override
  final String value;

  @override
  MajorRegion get majorRegion => MajorRegion.ulsan;

  const Ulsan(this.value);

  @override
  String toJson() => "${majorRegion.value} ($value)";

  @override
  String toString() => value;
}
