enum Jeju {
  jejuCity('제주시'),
  seogwipo('서귀포시');

  final String value;

  const Jeju(this.value);

  @override
  String toString() => value;
}
