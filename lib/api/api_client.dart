import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ok_ok/api/token_storage.dart';

class ApiClient {
  static const baseUrl = 'http://10.0.2.2:3000';

  static void Function()? onUnauthorized;

  static Uri _uri(String path, Map<String, String>? query) {
    return Uri.parse(
      '$baseUrl$path',
    ).replace(queryParameters: (query == null || query.isEmpty) ? null : query);
  }

  static _handle(http.Response res, {required bool auth}) {
    print(res.body);
    if (res.statusCode == 401 && auth) {
      onUnauthorized?.call();
      throw Exception(jsonDecode(res.body)['error']);
    }

    if (res.statusCode >= 400) {
      throw Exception(jsonDecode(res.body)['error']);
    }

    if (res.body.isEmpty) return;

    try {
      return jsonDecode(res.body);
    } on FormatException {
      return res.body;
    }
  }

  static Future<Map<String, String>> _headers({required bool auth}) async {
    final headers = {'Content-Type': 'application/json'};
    if (auth) {
      final token = await TokenStorage.read();
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  static Future<dynamic> get(
    String path, {
    Map<String, String>? query,
    bool auth = true,
  }) async {
    final res = await http.get(
      _uri(path, query),
      headers: await _headers(auth: auth),
    );
    return _handle(res, auth: auth);
  }

  static Future<dynamic> post(
    String path,
    Object? body, {
    Map<String, String>? query,
    bool auth = true,
  }) async {
    final res = await http.post(
      _uri(path, query),
      headers: await _headers(auth: auth),
      body: jsonEncode(body),
    );
    return _handle(res, auth: auth);
  }

  static Future<dynamic> put(
    String path,
    Object? body, {
    Map<String, String>? query,
    bool auth = true,
  }) async {
    final res = await http.put(
      _uri(path, query),
      headers: await _headers(auth: auth),
      body: jsonEncode(body),
    );
    return _handle(res, auth: auth);
  }

  static Future<dynamic> delete(
    String path, {
    Map<String, String>? query,
    bool auth = true,
  }) async {
    final res = await http.delete(
      _uri(path, query),
      headers: await _headers(auth: auth),
    );
    return _handle(res, auth: auth);
  }
}
