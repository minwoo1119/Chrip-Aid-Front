import 'package:chrip_aid/common/local_storage/local_storage.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authorityProvider = StateProvider((ref) => AuthorityType.user);

enum AuthorityType {
  user,
  orphanage;

  @override
  String toString() {
    switch (this) {
      case user:
        return 'users';
      case orphanage:
        return 'orphanages';
    }
  }

  static AuthorityType fromString(String? value) =>
      AuthorityType.values.firstWhereOrNull((e) => e.toString() == value) ??
      AuthorityType.user;
}