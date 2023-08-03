class RequestItemEntity {
  final String requestId;
  final String productName;
  final double price;
  final int requestCount;
  final int supportCount;
  final String message;
  final String productPhoto;

  RequestItemEntity({
    required this.requestId,
    required this.productName,
    required this.price,
    required this.requestCount,
    required this.supportCount,
    required this.message,
    required this.productPhoto,
  });
}
