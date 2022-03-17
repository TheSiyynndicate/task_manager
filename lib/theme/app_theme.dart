import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/constants/app_colors.dart';

import 'text_theme.dart';



class AppTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
      //2
        primaryColor: AppColors.greenPantone,
        scaffoldBackgroundColor: AppColors.oldLace,
        primarySwatch: createMaterialColor(AppColors.greenPantone),
        fontFamily: 'Quicksand',
        textTheme:  AppTextTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.greenPantone),
                elevation: MaterialStateProperty.all<double>(5.0),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )))),
        buttonTheme: ButtonThemeData(
          // 4
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: AppColors.greenPantone,
        ));
  }

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}

TextTheme AppTextTheme = TextTheme(
  bodyText1: GoogleFonts.quicksandTextTheme().bodyText1!.copyWith(
    fontSize: 12
  ),
  bodyText2: GoogleFonts.quicksandTextTheme().bodyText2,
  button: GoogleFonts.quicksandTextTheme().button,
  caption: GoogleFonts.quicksandTextTheme().caption,
  headline1: GoogleFonts.quicksandTextTheme().headline1 ,
  headline2: GoogleFonts.quicksandTextTheme().headline2,
  headline3: GoogleFonts.quicksandTextTheme().headline3,
  headline4: GoogleFonts.quicksandTextTheme().headline4,
  headline5: GoogleFonts.quicksandTextTheme().headline5,
  headline6: GoogleFonts.quicksandTextTheme().headline6,
  overline: GoogleFonts.quicksandTextTheme().overline,
  subtitle1: GoogleFonts.quicksandTextTheme().subtitle1,
  subtitle2: GoogleFonts.quicksandTextTheme().subtitle2,

);