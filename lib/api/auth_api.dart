import 'package:ok_ok/api/api_client.dart';
import 'package:ok_ok/api/token_storage.dart';

class AuthApi {
  static Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final data = await ApiClient.post('/auth/login', {
      'email': email,
      'password': password,
    });
    final token = data['token'] as String;
    await TokenStorage.save(token);
  }

  static Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    await ApiClient.post('/auth/create-account', {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    }, auth: false);
  }
}
