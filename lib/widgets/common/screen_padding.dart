import 'package:flutter/material.dart';

class ScreenPadding extends StatelessWidget {
  const ScreenPadding({super.key, required this.child, this.extra});

  final Widget child;
  final EdgeInsetsGeometry? extra;

  static const double horizontal = 20.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
      ).add(extra ?? EdgeInsets.zero),
      child: child,
    );
  }
}
