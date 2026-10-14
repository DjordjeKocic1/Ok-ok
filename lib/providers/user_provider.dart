import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/api/token_storage.dart';
import 'package:ok_ok/api/user_api.dart';
import 'package:ok_ok/modal/user.dart';

class UserProviderNotifier extends StateNotifier<AsyncValue<User?>> {
  UserProviderNotifier() : super(const AsyncData(null));

  Future<void> getUser() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => UserApi.getUser());
  }

  Future<void> updateUser({
    String? firstName,
    String? lastName,
    String? phone,
    List<SearchedDestinations>? searchedDestinations,
  }) async {
    final updated = await UserApi.updateUser(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      searchedDestinations: searchedDestinations,
    );
    state = AsyncData(updated);
  }

  Future<void> signOut() async {
    state = const AsyncData(null);
    await TokenStorage.clear();
  }
}

final userProvider =
    StateNotifierProvider<UserProviderNotifier, AsyncValue<User?>>((ref) {
      return UserProviderNotifier();
    });
