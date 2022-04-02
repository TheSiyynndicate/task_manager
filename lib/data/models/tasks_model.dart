/// message : "Test task list loaded successfully"
/// data : [{"title":"My first task","description":"Doing stuff","completed":false,"_id":"6247014d7850e1c152d2d1ef","owner":"6247005c7850e1c152d2d1e6","createdAt":"2022-04-01T13:42:37.098Z","updatedAt":"2022-04-01T13:42:37.098Z","__v":0},{"title":"My second task","description":"Doing more stuff","completed":false,"_id":"624702bf7850e1c152d2d1f2","owner":"6247005c7850e1c152d2d1e6","createdAt":"2022-04-01T13:48:47.451Z","updatedAt":"2022-04-01T13:48:47.451Z","__v":0}]

class TasksModel {
  TasksModel({
      String? message, 
      List<Data>? data,}){
    _message = message;
    _data = data;
}

  TasksModel.fromJson(dynamic json) {
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _message;
  List<Data>? _data;

  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// title : "My first task"
/// description : "Doing stuff"
/// completed : false
/// _id : "6247014d7850e1c152d2d1ef"
/// owner : "6247005c7850e1c152d2d1e6"
/// createdAt : "2022-04-01T13:42:37.098Z"
/// updatedAt : "2022-04-01T13:42:37.098Z"
/// __v : 0

class Data {
  Data({
      String? title, 
      String? description, 
      bool? completed, 
      String? id, 
      String? owner, 
      String? createdAt, 
      String? updatedAt, 
      int? v,}){
    _title = title;
    _description = description;
    _completed = completed;
    _id = id;
    _owner = owner;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _title = json['title'];
    _description = json['description'];
    _completed = json['completed'];
    _id = json['_id'];
    _owner = json['owner'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _title;
  String? _description;
  bool? _completed;
  String? _id;
  String? _owner;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  String? get title => _title;
  String? get description => _description;
  bool? get completed => _completed;
  String? get id => _id;
  String? get owner => _owner;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['description'] = _description;
    map['completed'] = _completed;
    map['_id'] = _id;
    map['owner'] = _owner;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}