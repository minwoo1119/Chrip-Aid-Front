enum Chungbuk {
  cheongjusi('청주시'),
  chungjusi('충주시'),
  jecheonsi('제천시');

  final String value;

  const Chungbuk(this.value);

  @override
  String toString() => value;
}
