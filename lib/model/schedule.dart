import 'package:trocatalentos_app/model/user.dart';

class Schedule {
  String providerId;
  String contractorId;
  int scheduleId;
  String date;
  bool finish;
  int talentId;
  String talentName;
  int rating;
  String description;
  int talentTcoin;
  String providerName;
  String contractorName;
  String providerAvatar;
  String contractorAvatar;
  String emailToSendMessage;



  Schedule(
      {this.providerId,
      this.contractorId,
      this.talentTcoin,
      this.scheduleId,
      this.date,
      this.finish,
      this.rating,
      this.description,
      this.talentId,
      this.talentName,
      this.providerName,
      this.contractorName,
      this.providerAvatar,
      this.contractorAvatar,
        this.emailToSendMessage
      });

  Schedule.fromJson(Map<String, dynamic> json){
    scheduleId = json['id'];
    providerId = json['id_provider'];
    contractorId = json['id_contractor'];
    finish = json['finish'];
    date = json['date'];
    talentTcoin = json['talent']['tcoin'];
    talentId = json['talent']['id'];
    talentName = json['talent']['talent'];
    rating = json['talent']['rating'];
    description = json['talent']['description'];
    providerName = providerId == User.userId ? User.name : json['users_data'][0]['username'];
    //contractorName = contractorId == User.userId ? User.name : json['users_data']['username'];
    providerAvatar= providerId == User.userId ? User.image : json['users_data'][0]['avatar'];
    //contractorAvatar = contractorId == User.userId ? User.image : json['users_data']['avatar'];
    emailToSendMessage =  json['users_data'][0]['email'];
  }

  Schedule.fromJsonToNotification(Map<String, dynamic> json){
    scheduleId = json['id'];
    providerId = json['id_provider'];
    contractorId = json['id_contractor'];
    finish = json['finish'];
    date = json['date'];
  }

}

class ScheduleResponse {
  List<Schedule> result=[];
  String error;

  ScheduleResponse(this.result, this.error);

  ScheduleResponse.fromJson(List<dynamic> json){
    json.forEach((value) {
      result.add(Schedule.fromJson(value));
    });
    error = "";
  }
  ScheduleResponse.withError(String errorValue)
      : result = null,//
        error = errorValue;
}

