enum Gangwon {
  chuncheonsi('춘천시'),
  wonjusi('원주시'),
  gangneungsi('강릉시'),
  donghaesi('동해시'),
  taebaeksi('태백시'),
  sokchosi('속초시'),
  samcheoksi('삼척시');

  final String value;

  const Gangwon(this.value);

  @override
  String toString() => value;
}
