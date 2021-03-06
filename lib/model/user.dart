
import 'package:trocatalentos_app/model/schedule.dart';

import 'notification.dart';

class User {
  static String userId;
  static String token;
  static String name;
  static String email;
  static int tcoin;
  static String image;
  static String age;
  static int qtsNewProposals;
  static bool haveNotifications = false;
  static Schedule lastSchedulefinished ;
  static bool canceled = false;
  static List<CanceledSchedule> scheduleListCanceled = [];



  User.fromJson(Map<String, dynamic> json) {
    userId = json['user']['id'];
    token = json['token'];
    name = json['user']['username'];
    email = json['user']['email'];
    tcoin = json['user']['tcoin'];
    image = json['user']['avatar'];
    age = json['user']['age'].toString();
    /*if(tcoin < 0){
      tcoin = 0;
    }*/
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

