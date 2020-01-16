import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ThemeDesign {

  const ThemeDesign();

  static const Color loginGradientStart = const Color(0xFFdff0fe);
  static const Color loginGradientEnd = const Color(0xff07426A);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}