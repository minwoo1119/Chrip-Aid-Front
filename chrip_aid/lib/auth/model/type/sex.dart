enum Sex {
  man("man"),
  woman("woman");

  final String value;

  const Sex(this.value);

  factory Sex.fromString(String value) =>
      Sex.values.firstWhere((element) => element.value == value);
}
