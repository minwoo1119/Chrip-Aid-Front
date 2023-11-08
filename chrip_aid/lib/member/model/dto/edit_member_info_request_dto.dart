abstract class EditMemberInfoRequestDto {
  final String name;
  final String password;

  EditMemberInfoRequestDto({
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toJson();
}
