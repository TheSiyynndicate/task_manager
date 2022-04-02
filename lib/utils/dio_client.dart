import 'package:dio/dio.dart';
import 'package:task_manager/constants/api_endpoints.dart';

class DioClient{
  ///The body of the POST request
  Map<String,dynamic>? data = {};
  ///Query for GET requests
  Map<String,dynamic>? query = {};
  ///The header
  Map<String,dynamic> header = {};

  ///Instantiation of the dio client
  Dio dio = Dio();

  ///Constructors
  DioClient({required this.header,this.data,this.query}){
    dio.options.baseUrl = ApiEndpoints.baseUrl;
    dio.options.headers = header;
    dio.options.queryParameters = query!;

  }

  Future<Response?> postRequest({required String path}) async {
    Response? response;
    try {
      response = await dio.post(path,data: data);
    } on Exception catch (e) {
      print("An error ocurred in the dio client ");
    }
    return response;
  }









}