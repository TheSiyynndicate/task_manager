import 'package:flutter/material.dart';
import 'package:task_manager/screens/login_screen.dart';
import 'package:task_manager/screens/on_boarding_screen.dart';
import 'package:task_manager/screens/registeration_screen.dart';
import 'package:task_manager/theme/app_theme.dart';

import 'constants/RouteConstants.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,


      routes: {
        '/':  (context)=>const OnBoardingScreen(),
        RouteConstants.home:(context)=>const Home(),
        RouteConstants.loginScreen:(context)=>const LoginScreen(),
        RouteConstants.onBoardingScreen:(context)=>const OnBoardingScreen(),
        RouteConstants.registrationScreen:(context)=>const RegistrationScreen(),
      },
    );
  }
}

