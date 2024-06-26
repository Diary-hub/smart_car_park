import 'package:flutter/material.dart';
import 'package:smart_car_park/utils/constants/colors.dart';

class KTextTheme {
  KTextTheme._();

  static TextTheme darkTheme = TextTheme(
    //Headlines
    headlineLarge:
        const TextStyle().copyWith(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: const TextStyle()
        .copyWith(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5)),
    headlineSmall:
        const TextStyle().copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
    //Titles
    titleLarge:
        const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
    titleMedium:
        const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
    titleSmall:
        const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
    // Bodys
    bodyLarge:
        const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
    bodyMedium: const TextStyle()
        .copyWith(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
    bodySmall: const TextStyle()
        .copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.5)),
    // labels
    labelLarge: const TextStyle().copyWith(
        fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5)),
    labelMedium: const TextStyle().copyWith(
        fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5)),
    labelSmall: const TextStyle()
        .copyWith(fontSize: 14, fontWeight: FontWeight.normal, color: KColors.secondaryColor),
  );
}
