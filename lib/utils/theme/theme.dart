import 'package:flutter/material.dart';
import 'package:smart_car_park/utils/theme/custom/appbar_theme.dart';
import 'package:smart_car_park/utils/theme/custom/bottomSheet_theme.dart';
import 'package:smart_car_park/utils/theme/custom/checkbox_theme.dart';
import 'package:smart_car_park/utils/theme/custom/chip_theme.dart';
import 'package:smart_car_park/utils/theme/custom/elevatedButton_theme.dart';
import 'package:smart_car_park/utils/theme/custom/outlinedButton_thene.dart';
import 'package:smart_car_park/utils/theme/custom/textField_theme.dart';
import 'package:smart_car_park/utils/theme/custom/text_theme.dart';

class KAppTheme {
  KAppTheme._();

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Rabar",
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    textTheme: KTextTheme.darkTheme,
    chipTheme: KChipTheme.darkTheme,
    appBarTheme: KAppBarTheme.darkTheme,
    checkboxTheme: KCheckboxTheme.darkTheme,
    bottomSheetTheme: KBottomSheetTheme.darkTheme,
    elevatedButtonTheme: KElevatedTheme.darkTheme,
    outlinedButtonTheme: KOutlinedButtonTheme.darkTheme,
    inputDecorationTheme: KTextFieldTheme.darkTheme,
  );
}
