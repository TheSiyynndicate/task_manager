import 'package:flutter/material.dart';

class TaskCards extends StatefulWidget {
  const TaskCards({Key? key}) : super(key: key);

  @override
  State<TaskCards> createState() => _TaskCardsState();
}

class _TaskCardsState extends State<TaskCards> {

  //Test bolean
  bool _checkVal = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Container(
        padding: EdgeInsets.all(5.0),
        color: Colors.green,
child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: CheckboxListTile(value: _checkVal,onChanged: (val){

            },


            )


            ),
        Expanded(
          flex: 8,
          child: ,


          )
          ],
        ),
      ),
    );
  }
}
