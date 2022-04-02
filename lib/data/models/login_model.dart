/// message : "Logged in successfully"
/// data : {"user":{"_id":"6247005c7850e1c152d2d1e6","name":"Test","email":"test@test.com","createdAt":"2022-04-01T13:38:36.554Z","updatedAt":"2022-04-01T13:42:15.425Z","__v":4},"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjQ3MDA1Yzc4NTBlMWMxNTJkMmQxZTYiLCJpYXQiOjE2NDg4MjA1MzV9.ThotR16Det0qhsUCuqNpfFssSHKcYCJOTW_iCYfuGKw"}

class LoginModel {
  LoginModel({
      String? message, 
      Data? data,}){
    _message = message;
    _data = data;
}

  LoginModel.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _message;
  Data? _data;

  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// user : {"_id":"6247005c7850e1c152d2d1e6","name":"Test","email":"test@test.com","createdAt":"2022-04-01T13:38:36.554Z","updatedAt":"2022-04-01T13:42:15.425Z","__v":4}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjQ3MDA1Yzc4NTBlMWMxNTJkMmQxZTYiLCJpYXQiOjE2NDg4MjA1MzV9.ThotR16Det0qhsUCuqNpfFssSHKcYCJOTW_iCYfuGKw"

class Data {
  Data({
      User? user, 
      String? token,}){
    _user = user;
    _token = token;
}

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
  }
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token'] = _token;
    return map;
  }

}

/// _id : "6247005c7850e1c152d2d1e6"
/// name : "Test"
/// email : "test@test.com"
/// createdAt : "2022-04-01T13:38:36.554Z"
/// updatedAt : "2022-04-01T13:42:15.425Z"
/// __v : 4

class User {
  User({
      String? id, 
      String? name, 
      String? email, 
      String? createdAt, 
      String? updatedAt, 
      int? v,}){
    _id = id;
    _name = name;
    _email = email;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _name;
  String? _email;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}