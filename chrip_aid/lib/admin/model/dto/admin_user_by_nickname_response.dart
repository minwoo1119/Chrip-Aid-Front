class UserResponseDto {
  final String name;
  final String email;
  final int age;
  final String sex;
  final String nickname;
  final String region;
  final String phoneNumber;
  final String profilePhoto;
  final String role;

  UserResponseDto({
    required this.name,
    required this.email,
    required this.age,
    required this.sex,
    required this.nickname,
    required this.region,
    required this.phoneNumber,
    required this.profilePhoto,
    required this.role,
  });

  // JSON 데이터를 Dart 객체로 변환하는 factory 메서드
  factory UserResponseDto.fromJson(Map<String, dynamic> json) {
    return UserResponseDto(
      name: json['name'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
      sex: json['sex'] as String,
      nickname: json['nickname'] as String,
      region: json['region'] as String,
      phoneNumber: json['phone_number'] as String,
      profilePhoto: json['profile_photo'] as String,
      role: json['role'] as String,
    );
  }

  // Dart 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'sex': sex,
      'nickname': nickname,
      'region': region,
      'phone_number': phoneNumber,
      'profile_photo': profilePhoto,
      'role': role,
    };
  }
}
