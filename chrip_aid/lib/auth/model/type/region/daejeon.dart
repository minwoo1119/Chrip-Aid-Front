enum Daejeon {
  donggu('동구'),
  junggu('중구'),
  seogu('서구'),
  yuseonggu('유성구'),
  daedeokgu('대덕구');

  final String value;

  const Daejeon(this.value);

  @override
  String toString() => value;
}
