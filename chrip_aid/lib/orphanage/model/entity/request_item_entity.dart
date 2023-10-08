class RequestItemEntity {
  final int requestId;
  final String productName;
  final int price;
  final int requestCount;
  final int supportCount;
  final String message;
  final String productPhoto;
  final String state;

  RequestItemEntity({
    required this.requestId,
    required this.productName,
    required this.price,
    required this.requestCount,
    required this.supportCount,
    required this.message,
    required this.productPhoto,
    required this.state
  });
}
