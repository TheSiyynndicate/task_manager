import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/constants/app_colors.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/models/tasks_model.dart';
import 'package:task_manager/utils/task_cards.dart';

class HomeScreen extends StatefulWidget {
  final LoginModel? loginModel;

  const HomeScreen({Key? key, this.loginModel}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final streamController = StreamController(
    onPause: () => print('Paused'),
    onResume: () => print('Resumed'),
    onCancel: () => print('Cancelled'),
    onListen: () => print('Listens'),
  );
  //
  late TasksModel? tasksModel;

  //
  var future;

  //
  Size? size;

  //
  final _titleController = TextEditingController();

  //
  final _descriptionController = TextEditingController();

  Future<Stream> feedStream() async {
    final stream = Stream<int>.periodic(
        const Duration(seconds: 1), (count) => count);
    await streamController.addStream(stream);
    return stream;
  }
  @override
  void initState() {
    super.initState();

    streamController.stream.listen(
          (event) => print('Event: $event'),
      onDone: () => print('Done'),
      onError: (error) => print(error),
    );
    loginModel = widget.loginModel;
    tasksModel = TasksModel();
    future = _();
  }

  Future<TasksModel?> _() async {
    Dio dio = Dio();
    Response response;

    print('doing');
    try {
      feedStream();
      response = await dio.get("https://task-managero.herokuapp.com/tasks",
          options: Options(
              headers: {"Authorization": "Bearer ${loginModel!.data!.token}"}));

      tasksModel = TasksModel.fromJson(response.data);
    } on Exception catch (e) {
      // TODO
      print(e);
    }

    return tasksModel;
  }

  late LoginModel? loginModel;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: FutureBuilder<TasksModel?>(
            future: future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Material(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Scaffold(
                      resizeToAvoidBottomInset: true,
                      body: Column(
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                        ))),
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                          'You have 4 remaining tasks',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(color: Colors.white),
                                        ))
                                  ]),
                            ]),
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      tileMode: TileMode.mirror,
                                      stops: [
                                        0.1,
                                        0.9,
                                      ],
                                      colors: [
                                        AppColors.greenPantone,
                                        AppColors.rustyRed
                                      ],
                                    )),
                                constraints: const BoxConstraints.expand(),
                                child: const Card(
                                  elevation: 0.0,
                                  color: Colors.transparent,
                                ),
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          Expanded(
                              flex: 5,
                              child: SizedBox(
                                height: size!.height * 0.1,
                                width: size!.width,
                                child: Scrollbar(
                                    child: ListView.builder(
                                        itemCount: tasksModel!.data!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return TaskCards(
                                            title: tasksModel!.data!
                                                .elementAt(index)
                                                .title,
                                          );
                                        })),
                              )),
                        ],
                      ),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          _showDialog(context: context);
                        },
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Icon(Icons.error_outline);
              } else {
                return const Center(child: const CircularProgressIndicator());
              }
            }));
  }

  _showDialog({required BuildContext context}) async {
    return (await showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Alert'),
          elevation: 5.0,
          content: Column(
            children: <Widget>[
              Container(
                height: 50,
                child: TextFormField(
                  controller: _titleController,
                ),
              ),
              Container(
                height: 50,
                child: TextFormField(
                  controller: _descriptionController,
                ),
              ),         Container(
                height: 50,
                child: ElevatedButton(
                  child: Container(),
                  onPressed: (){},
                )
              ),

            ],
          ),
        );
      },
    ));
  }
}
