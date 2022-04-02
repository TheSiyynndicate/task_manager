import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manager/constants/api_endpoints.dart';

class DioClient{
  ///The body of the POST request
  Map<String,dynamic> data = {};
  ///Query for GET requests
  Map<String,dynamic> query = {};
  ///The header
  Map<String,dynamic>? header = {};

  ///Instantiation of the dio client
  Dio dio = Dio();

  ///Constructors
  DioClient({required this.header,required this.data,required this.query}){
    dio.options.baseUrl = ApiEndpoints.baseUrl;
    dio.options.headers = header;
    dio.options.queryParameters = query;

  }

  Future<Response?> postRequest({required String path}) async {
    Response? response;
    try {
      response = await dio.post(path,data: data);
      if (kDebugMode) {
        print("The response from postRequest(): $response");
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print("An error occurred in the dio client method postRequest()");
      }
    }
    return response;
  }

  Future<Response?> getRequest({required String path}) async{
    Response? response;
    try {
      response = await dio.get(path);
      if (kDebugMode) {
        print("The response from getRequest(): $response");
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print("An error occurred in the dio client method getRequest()");
      }
    }
    return response;
  }









}