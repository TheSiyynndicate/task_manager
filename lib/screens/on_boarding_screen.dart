import 'package:flutter/material.dart';
import 'package:task_manager/constants/RouteConstants.dart';
import 'package:task_manager/constants/app_colors.dart';

class OnBoardingScreen extends StatelessWidget {

  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Center(child: Text('Welcome',style: Theme.of(context).textTheme.headline3,textScaleFactor: 2))),
            Expanded(flex:4, child: Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    child: Text('Login',textScaleFactor: 2.5,style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: AppColors.oldLace
                    )
                    ),
                    onPressed:()=> Navigator.pushNamed(context, RouteConstants.loginScreen),
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.greenPantone,
                        elevation: 2.0,
                        fixedSize: const Size(200,100)
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Register',textScaleFactor: 2.5,style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: AppColors.oldLace
                    )),
                    onPressed:(){
                      Navigator.pushNamed(context, RouteConstants.registrationScreen);
                    } ,
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.greenPantone,
                        elevation: 2.0,
                        fixedSize: const Size(200,100)
                    ),
                  ),
                ],
              ),
            )),
            Expanded(flex:3, child: Column(
              children: [

              ],
            )),

          ],
        ),
      ),
    );
  }
}


