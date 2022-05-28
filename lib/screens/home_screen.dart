import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/constants/api_endpoints.dart';
import 'package:task_manager/constants/app_colors.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/models/tasks_model.dart';
import 'package:task_manager/utils/dio_client.dart';
import 'package:task_manager/utils/task_cards.dart';

class HomeScreen extends StatefulWidget {
  final LoginModel? loginModel;

  const HomeScreen({Key? key, this.loginModel}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final streamController = StreamController.broadcast(
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

  @override
  void initState() {
    super.initState();

    streamController.stream.listen(
      (event) {}
    );
    loginModel = widget.loginModel;
    tasksModel = TasksModel();
    future = _();
  }

  @override
  void dispose() {
    streamController.close();
    streamController.sink.close();

    super.dispose();
  }

  Stream<TasksModel?> stream() async* {
    Dio dio = Dio();
    while (true) {
      try {
        Response response = await dio.get(
            "https://task-managero.herokuapp.com/tasks",
            options: Options(headers: {
              "Authorization": "Bearer ${loginModel!.data!.token}"
            }));

        tasksModel = TasksModel.fromJson(response.data);
      } on Exception catch (e) {
        // TODO
        print(e);
      }
    }
    streamController.sink.add(tasksModel);
    yield tasksModel;
  }

  _saveNewTask() async {
    Map<String,dynamic> _data =  {
      "title": _titleController.text,
      "description": _descriptionController.text
    };
    DioClient dioClient = DioClient(header: {
      "Authorization": "Bearer ${loginModel!.data?.token}"
    }, data:json.encode(_data), query: {});

    Response? response =
        await dioClient.postRequest(path: ApiEndpoints.createTask);

    if (response!.statusCode == 201) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Added successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.greenPantoneG,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Failed to add task",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.greenPantoneG,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<TasksModel?> _() async {
    Dio dio = Dio();
    Response response;


    try {
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
                Timer.periodic(const Duration(seconds: 5), (timer) async {
                  Dio dio = Dio();
                  try {
                    if (kDebugMode) {
                      print("help");
                    }
                    Response response = await dio.get(
                        "https://task-managero.herokuapp.com/tasks",
                        options: Options(headers: {
                          "Authorization": "Bearer ${loginModel!.data!.token}"
                        }));

                    tasksModel = TasksModel.fromJson(response.data);
                    streamController.sink.add(tasksModel);
                  } on Exception catch (e) {
                    // TODO
                    if (kDebugMode) {
                      print(e);
                    }
                  }

                });
                return Material(
                  child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    appBar: AppBar(
toolbarHeight: 50.0,

                    ),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
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
                                          'MY TASK',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green, fontSize: 30),
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
                                    child: StreamBuilder(
                                        stream: streamController.stream,
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView.builder(
                                                itemCount:
                                                    tasksModel!.data!.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {

                                                  return TaskCards(
                                                    title: tasksModel!.data!
                                                        .elementAt(index)
                                                        .title,
                                                  );

                                                });
                                          } else if (snapshot.hasError) {
                                            return Icon(Icons.error_outline);
                                          } else {
                                            return Center(
                                                child:
                                                    const CircularProgressIndicator());
                                          }
                                        })),
                              )),
                        ],
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        _showDialog(context: context);
                      },
                      child: const Icon(Icons.add),
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
          title: Text('Create a task'),
          scrollable: true,
          elevation: 5.0,
          content: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 50,
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 10.0),
                    errorMaxLines: 1,
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.greenPantoneG, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    alignLabelWithHint: true,
                    errorStyle: TextStyle(fontSize: 12),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.greenPantoneG, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    constraints:
                        BoxConstraints.tight(Size(double.maxFinite, 70)),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.rustyRed, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: 'Title',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 50,
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 10.0),
                    errorMaxLines: 1,
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.greenPantoneG, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    alignLabelWithHint: true,
                    errorStyle: TextStyle(fontSize: 12),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.greenPantoneG, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    constraints:
                        BoxConstraints.tight(Size(double.maxFinite, 70)),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.rustyRed, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: 'Description',
                  ),
                ),
              ),
              Container(
                  height: 50,
                  child: ElevatedButton(
                    child: Text('Add task to the to do list'),
                    onPressed: () => _saveNewTask(),
                  )),
            ],
          ),
        );
      },
    ));
  }
}
