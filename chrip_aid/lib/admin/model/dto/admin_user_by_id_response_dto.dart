class UserRequestDto {
  final String id;

  UserRequestDto({required this.id});

  Map<String, dynamic> toQueryParams() {
    return {
      'id': id,
    };
  }
}
