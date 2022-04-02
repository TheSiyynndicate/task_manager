import 'package:flutter/material.dart';
import 'package:task_manager/constants/app_colors.dart';

class TaskCards extends StatefulWidget {
  final String? title;
  const TaskCards({Key? key, this.title}) : super(key: key);

  @override
  State<TaskCards> createState() => _TaskCardsState();
}

class _TaskCardsState extends State<TaskCards> {
  //
  String? title;
  //
  late FocusNode _focusNode;

  //Test boolean
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
                  flex: 2,
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
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(title!,style: Theme.of(context).textTheme.bodyText1,)
                  ],
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
    title =widget.title;
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('Change update');
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('update');
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
