import 'package:flutter/material.dart';

const double _designWidth = 375.0;
const double _designHeight = 812.0;

class Responsive {
  final BuildContext context;
  late final Size screenSize;
  late final double scaleWidth;
  late final double scaleHeight;
  late final double scaleText;

  Responsive(this.context) {
    screenSize = MediaQuery.of(context).size;
    scaleWidth = screenSize.width / _designWidth;
    scaleHeight = screenSize.height / _designHeight;
    scaleText = scaleWidth.clamp(0.75, 1.15);
  }

  double w(double size) => size * scaleWidth;
  double h(double size) => size * scaleHeight;
  double sp(double size) => size * scaleText;
  double r(double size) => size * scaleWidth.clamp(0.85, 1.1);
}

extension ResponsiveExtension on BuildContext {
  Responsive get responsive => Responsive(this);

  double sp(double size) => Responsive(this).sp(size);
  double w(double size) => Responsive(this).w(size);
  double h(double size) => Responsive(this).h(size);
  double r(double size) => Responsive(this).r(size);
}
