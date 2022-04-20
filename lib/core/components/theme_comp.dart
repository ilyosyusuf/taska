import 'package:flutter/material.dart';
import 'package:taska/core/constants/colorconst.dart';

class ThemeComp {
  static ThemeData get myTheme => ThemeData(
        colorScheme: ColorScheme.light(primary: ColorConst.kPrimaryColor),
        scaffoldBackgroundColor: ColorConst.kPrimaryColor,
      );
}
