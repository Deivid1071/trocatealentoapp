
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


  User.fromJsonRegister(Map<String, dynamic> json) {
    userId = json['id'];
    name = json['username'];
    email = json['email'];
    tcoin = json['tcoin'];
  }

}

class UserResponse {
  final User result;
  final String error;

  UserResponse(this.result, this.error);

  UserResponse.fromJson(Map<String, dynamic> json)
      : result = User.fromJson(json),
        error = "";

  UserResponse.fromJsonRegister(Map<String, dynamic> json)
      : result = User.fromJsonRegister(json),
        error = "";


  UserResponse.withError(String errorValue)
      : result = null,//
        error = errorValue;
}
