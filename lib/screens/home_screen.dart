import 'package:flutter/material.dart';
import 'package:task_manager/constants/app_colors.dart';
import 'package:task_manager/utils/task_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 7,
                          child: Center(
                              child: Text(
                            'My Task',
                            style: Theme.of(context).textTheme.subtitle1,
                          ))),
                      Expanded(
                          flex: 2,
                          child: Text(
                            'You have 4 remaining tasks',
                            style: Theme.of(context).textTheme.subtitle1,
                          ))
                    ]),
              ]),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    tileMode: TileMode.mirror,
                    stops: [
                      0.1,
                      0.9,
                    ],
                    colors: [AppColors.greenPantoneG, AppColors.rustyRedG],
                  )),
                  constraints: const BoxConstraints.expand(),
                  child: const Card(
                    elevation: 0.0,
                    color: Colors.transparent,

                  ),
                )),
            Expanded(
                flex: 5,
                child: Container(
                  constraints: BoxConstraints.expand(),

                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      TaskCards()
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
