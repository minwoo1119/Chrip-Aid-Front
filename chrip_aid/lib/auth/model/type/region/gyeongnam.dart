enum Gyeongnam {
  changwonsi('창원시'),
  jinjusi('진주시'),
  tongyeongsi('통영시'),
  sacheonsi('사천시'),
  gimhaesi("김해시"),
  miryangsi("밀양시"),
  geojesi("거제시"),
  yangsansi("양산시");

  final String value;

  const Gyeongnam(this.value);

  @override
  String toString() => value;
}
