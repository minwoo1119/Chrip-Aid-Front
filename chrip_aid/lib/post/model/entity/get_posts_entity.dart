class GetPostsEntity {
  final int reviewId;
  final String title;
  final String content;
  final String photo;
  final String date;
  final String name;
  final String orphanageName;
  final List<String> productNames;

  GetPostsEntity({
    required this.reviewId,
    required this.title,
    required this.content,
    required this.photo,
    required this.date,
    required this.name,
    required this.orphanageName,
    required this.productNames,
  });
}
