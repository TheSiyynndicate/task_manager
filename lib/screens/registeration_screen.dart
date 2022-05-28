import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/constants/api_endpoints.dart';
import 'package:task_manager/constants/app_colors.dart';
import 'package:task_manager/utils/dio_client.dart';

class RegistrationScreen extends StatefulWidget {

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _passwordTextController= TextEditingController();
  final _nameTextController= TextEditingController();
  final _rPasswordTextController= TextEditingController();
  //
  late FocusNode _emailFocusNode;
  late FocusNode _nameFocusNode;
  late FocusNode _rPassFocusNode;
  //
  String _nameText = '';
  String _rPasswordText = '';
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  //
  late FocusNode _passFocusNode;
  //

  //
  bool isPressed = false;
  //
  String _emailText = '';
  //
  String _passwordText = '';
  //
  final _emailTextController = TextEditingController();

  //


  @override
  void initState() {
    super.initState();
    _passFocusNode =  FocusNode();
    _emailFocusNode =  FocusNode();
    _nameFocusNode =  FocusNode();
    _rPassFocusNode =  FocusNode();


  } //
  @override
  void dispose() {
    // TODO: implement dispose
    _passFocusNode.dispose();
    _nameFocusNode.dispose();
    _rPassFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    Size size = MediaQuery.of(context).size;
    return Scaffold(

        appBar: AppBar(
          title: Text('Registration', textScaleFactor: 1.5,),
        ),
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints.tight(size),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),

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
                                      color: Colors.grey, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                label: Text('Name', textScaleFactor: 1.5)),
                            controller: _nameTextController,
                            focusNode: _nameFocusNode,
                            validator: (val) {},
                            onFieldSubmitted: (val){
                              _nameText = val;
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
                                      color: Colors.grey, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                label: Text('Email', textScaleFactor: 1.5)),
                            controller: _emailTextController,
                            focusNode: _emailFocusNode,
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
                                      color: Colors.grey, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                label: Text('Password', textScaleFactor: 1.5)),
                            controller: _passwordTextController,
                            focusNode: _passFocusNode,
                            validator: (val) {
                              if(val!.isEmpty){
                                return 'Password must be filled';
                              }
                            },
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
                          TextFormField(
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                label: Text('Repeat Password', textScaleFactor: 1.5)),
                            controller: _rPasswordTextController,
                            focusNode: _rPassFocusNode,
                            validator: (val) {
                              if(val!.isEmpty){
                                return 'Password must be filled'
                                ;
                              }
                              if(_rPasswordTextController.text != _passwordTextController.text){
                                return 'Passwords don\'t match';
                              }
                            },
                            onFieldSubmitted: (val){
                              _rPasswordText = val;
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
                            ),) : Text('Register', textScaleFactor: 1.5),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(400, 50)),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }

  _login() async {
    Map<String,dynamic> _data = {
      "name":_nameTextController.text,
      "email":_emailTextController.text,
      "password":_passwordTextController.text
    };
    //
    DioClient dio = DioClient(header: {
      "Content-Type":"application/json"
    }, data:json.encode(_data), query: {});
    if(_formKey.currentState!.validate()){

      var response  = await dio.postRequest(path: ApiEndpoints.usersCreate);
      print(response!.data);

      Fluttertoast.showToast(msg: 'Registered successfully!',backgroundColor: AppColors.greenPantone);
      Future.delayed(const Duration(seconds: 2),(){
        Navigator.pop(context);
      });

    }
  }
}