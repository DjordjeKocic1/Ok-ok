import 'package:flutter/material.dart';

class ScreenPadding extends StatelessWidget {
  const ScreenPadding({super.key, required this.child, this.extra});

  final Widget child;
  final EdgeInsetsGeometry? extra;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          0,
          20,
          10,
        ).add(extra ?? EdgeInsets.zero),
        child: child,
      ),
    );
  }
}
