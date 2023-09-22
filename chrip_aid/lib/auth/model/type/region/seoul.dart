import 'package:chrip_aid/auth/model/type/region.dart';
import 'package:chrip_aid/auth/model/type/region/sub_region.dart';

enum Seoul implements SubRegion {
  jongrogu('종로구'),
  junggu('중구'),
  yongsangu('용산구'),
  seongdonggu('성동구'),
  gwangjingu('광진구'),
  dongdaemungu("동대문구"),
  jungranggu("중랑구"),
  seonbukgu("성북구"),
  gangbukgu("강북구"),
  dobongu("도봉구"),
  nowongu("노원구"),
  eunpyeonggu("은평구"),
  seodaemungu("서대문구"),
  mapogu("마포구"),
  yangcheongu("양천구"),
  gangseogu("강서구"),
  gurogu("구로구"),
  geumcheongu("금천구"),
  yeongdeungpogu("영등포구"),
  dongjakgu("동작구"),
  gwanakgu('관악구'),
  seochcogu('서초구'),
  gangnamgu('강남구'),
  songpagu('송파구'),
  gangdonggu('강동구');

  @override
  final String value;

  @override
  MajorRegion get majorRegion => MajorRegion.seoul;

  const Seoul(this.value);

  @override
  String toJson() => "${majorRegion.value} ($value)";

  @override
  String toString() => value;
}
