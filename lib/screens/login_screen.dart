import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/constants/RouteConstants.dart';
import 'package:task_manager/constants/api_endpoints.dart';
import 'package:task_manager/constants/app_colors.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/utils/dio_client.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
  bool isPressed = false;
  //
  String _emailText = '';

  //
  String _passwordText='';
  //
  late LoginModel loginModel;
  //focus node for the login text field
  late FocusNode _loginFocus;

  //focus node for the password text field
  late FocusNode _passFocus;

  //The text field controller
  final _loginController = TextEditingController();

  //The text field controller
  final _passwordController = TextEditingController();

  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(350, 350)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      label: Text('Email', textScaleFactor: 1.5)),
                                  controller: _loginController,
                                  focusNode: _loginFocus,
                                  validator: (val) {},
                                  onFieldSubmitted: (val){
                                    _emailText = val;
                                  },
                                ),
                              ],
                            )),
                        Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      label: Text('Password', textScaleFactor: 1.5)),
                                  controller: _passwordController,
                                  focusNode: _passFocus,
                                  validator: (val) {},
                                  onFieldSubmitted: (val){
                                    _passwordText = val;
                                  },
                                ),
                              ],
                            )),
                        Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () => isPressed? (){} :_login(),
                                  child: isPressed? const Center(child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.oldLace),
                                  ),) : Text('Login'),
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: Size(400, 50)),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void _setIsPressed(){
    setState(() {
      isPressed = !isPressed;
    });
  }
  _login() async {
    Map<String,dynamic> _data ={"email":_loginController.text,"password":_passwordController.text};
    _setIsPressed();

    DioClient dioClient = DioClient(header: {"Content-Type":"application/json"},data: json.encode(_data),query: {});
    Response? response;

    print(_emailText);
    print(_passwordText);
    response = await dioClient.postRequest(path: ApiEndpoints.login);




    log('This is the response when I tried to login: ${response!.data}');

    if (response.statusCode == 200) {
      _setIsPressed();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(loginModel: loginModel,)));
      loginModel = LoginModel.fromJson(response.data);
    } else {
      _setIsPressed();
      Fluttertoast.showToast(
          msg: "Either you haven't registered or bad credentials",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }

  @override
  void initState() {
    _loginFocus = FocusNode();
    _passFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _loginFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }
}
