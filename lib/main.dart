import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ok_ok/screens/login.dart';

class AppColors {
  static const primary = Color(0xFF6843E6);
  static const primaryDark = Color(0xFF1E1B4B);
  static const background = Color(0xFFFAF9FF);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFE5E3F0);
  static const textSecondary = Color(0xFF6B7280);
  static const success = Color(0xFF10B981);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    fn,
  ) {
    runApp(
      MaterialApp(
        title: 'Ok ok',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            brightness: Brightness.light,
            primary: AppColors.primary,
            surface: AppColors.surface,
          ),
          textTheme: GoogleFonts.latoTextTheme(),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
        home: const Login(),
      ),
    );
  });
}
