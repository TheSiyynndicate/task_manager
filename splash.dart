import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'on_boarding_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }


  _navigatetohome()async{
   await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnBoardingScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( color: Colors.greenAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 100, width: 100, color:Colors.red,),
              Container(
                child: Text('Check This', style: TextStyle(fontSize: 34, fontWeight:FontWeight.bold, fontStyle: FontStyle.italic, color:
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
