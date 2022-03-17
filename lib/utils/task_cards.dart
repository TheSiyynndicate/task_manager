import 'package:flutter/material.dart';
import 'package:task_manager/constants/app_colors.dart';

class TaskCards extends StatefulWidget {
  const TaskCards({Key? key}) : super(key: key);

  @override
  State<TaskCards> createState() => _TaskCardsState();
}

class _TaskCardsState extends State<TaskCards> {
  //
  late FocusNode _focusNode;

  //Test bolean
  bool _checkVal = false;

  _changeVal(val) {
    _checkVal = val;
    print('Val changed $val');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        height: 125,
        width: 300,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.greenPantone,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Checkbox(
                    focusNode: _focusNode,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    value: _checkVal,
                    onChanged: (val) {
                      setState(() {
                        _changeVal(val);
                      });
                    },
                  )),
              Expanded(
                flex: 8,
                child: Row(
                  children: <Widget>[],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
