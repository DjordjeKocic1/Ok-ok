import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/providers/user_provider.dart';
import 'package:ok_ok/screens/login.dart';
import 'package:ok_ok/screens/tabs.dart';
import 'package:ok_ok/api/token_storage.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_init);
  }

  bool isTokenExpired(String token) {
    try {
      final payload = token.split('.')[1];
      final json =
          jsonDecode(
                utf8.decode(base64Url.decode(base64Url.normalize(payload))),
              )
              as Map<String, dynamic>;
      final exp = json['exp'] as int;
      return DateTime.now().millisecondsSinceEpoch ~/ 1000 >= exp;
    } catch (_) {
      return true;
    }
  }

  Future<void> _init() async {
    final token = await TokenStorage.read();
    if (!mounted) return;

    Widget next = const LoginScreen();

    if (token != null) {
      if (isTokenExpired(token)) {
        await TokenStorage.clear();
      } else {
        try {
          await ref.read(userProvider.notifier).getUser();
          final user = ref.read(userProvider).value;
          if (user != null) next = const TabsScreen();
        } catch (_) {}
      }
    }

    if (!mounted) return;

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => next));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
