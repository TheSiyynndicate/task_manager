class ApiEndpoints{
  /// *
  ///The base url
  static const String baseUrl = "https://task-managero.herokuapp.com";
  ///POST
  ///Logs in  the user and returns a token which is to be stored
  static const String login = "/users/login";
  ///POST
  ///Logs in  the user and returns a token which is to be stored
  static const String createTask = "/tasks/create-task";
}

///https://task-managero.herokuapp.com/users/login