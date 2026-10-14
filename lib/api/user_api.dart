import 'package:ok_ok/api/api_client.dart';
import 'package:ok_ok/modal/user.dart';

class UserApi {
  static Future<User> getUser() async {
    final data = await ApiClient.get('/user');
    return User.fromJson(data['user'] as Map<String, dynamic>);
  }

  static Future<User> updateUser({
    String? firstName,
    String? lastName,
    String? phone,
    List<SearchedDestinations>? searchedDestinations,
  }) async {
    final data = await ApiClient.put('/user', {
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (phone != null) 'phone': phone,
      if (searchedDestinations != null)
        'searchedDestinations': searchedDestinations
            .map((d) => d.toJson())
            .toList(),
    });
    return User.fromJson(data['user'] as Map<String, dynamic>);
  }
}
