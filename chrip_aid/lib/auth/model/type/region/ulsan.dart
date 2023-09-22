enum Ulsan {
  junggu('중구'),
  namgu('남구'),
  donggu('동구'),
  bukgu('북구'),
  uljugun('울주군');

  final String value;

  const Ulsan(this.value);

  @override
  String toString() => value;
}
