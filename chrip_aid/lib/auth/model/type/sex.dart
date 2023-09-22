enum Sex {
  man("m", '남성'),
  woman("w", '여성');

  final String value;
  final String string;

  const Sex(this.value, this.string);

  factory Sex.fromString(String value) =>
      Sex.values.firstWhere((element) => element.value == value);

  @override
  String toString() => string;
}
