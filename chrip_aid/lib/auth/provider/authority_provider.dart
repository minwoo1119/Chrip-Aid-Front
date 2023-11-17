import 'package:chrip_aid/common/local_storage/local_storage.dart';
import 'package:chrip_aid/common/utils/log_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late final StateProvider<AuthorityType> authorityProvider;

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

Future initAuthority() async {
  final ref = ProviderContainer();
  final value = await ref.read(localStorageProvider).read(key: 'authority');
  logging("init Authority", value ?? "null");
  final authority = AuthorityType.fromString(value);
  authorityProvider = StateProvider((ref) => authority);
}

Future saveAuthority(Ref ref) async {
  final authority = ref.read(authorityProvider);
  final value = authority.toString();
  logging("save Authority", value);
  await ref.read(localStorageProvider).write(key: 'authority', value: value);
}
