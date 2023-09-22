import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Busan implements SubRegion {
  junggu('중구'),
  seogu('서구'),
  donggu('동구'),
  yeongdogu('영도구'),
  busanjingu('부산진구'),
  dongnaegu('동래구'),
  namgu('남구'),
  bukgu('북구'),
  haeundaegu('해운대구'),
  sahagu('사하구'),
  geumjeonggu('금정구'),
  gangseogu('강서구'),
  yeonjegu('연제구'),
  suyeongogu('수영구'),
  sasanggu('사상구'),
  gijanggun("기장군");

  @override
  final String value;

  @override
  MajorRegion get majorRegion => MajorRegion.busan;

  const Busan(this.value);

  @override
  String toJson() => "${majorRegion.value} ($value)";

  @override
  String toString() => value;
}
