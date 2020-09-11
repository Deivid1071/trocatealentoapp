
class User {
  static String userId;
  static String token;
  static String name;
  static String email;
  static int tcoin;


  User.fromJson(Map<String, dynamic> json) {
    userId = json['user']['id'];
    token = json['token'];
    name = json['user']['username'];
    email = json['user']['email'];
    tcoin = json['user']['tcoin'];
  }

}

class UserResponse {
  final User result;
  final String error;

  UserResponse(this.result, this.error);

  UserResponse.fromJson(Map<String, dynamic> json)
      : result = User.fromJson(json),
        error = "";

  UserResponse.withError(String errorValue)
      : result = null,//
        error = errorValue;
}
