import 'package:trocatalentos_app/model/proposal.dart';
import 'package:trocatalentos_app/model/schedule.dart';
import 'package:trocatalentos_app/model/user.dart';

class Notification {
  List<Proposal> proposalList = [];
  Schedule scheduleNotification;

  Notification({this.proposalList, this.scheduleNotification});

  Notification.fromJson(Map<String, dynamic> json) {
    List proposalListJson = json['proposals'];
    if(proposalListJson != []){
      proposalListJson.forEach((value) {
        proposalList.add(Proposal.fromJson(value));
      });
    }
    if(proposalList != []){
      User.qtsNewProposals = proposalList.length;
    }else{
      User.qtsNewProposals = 0;
    }
    if(json['finished_schedule'] != null){
      scheduleNotification = Schedule.fromJson(json['finished_schedule']);
    }
    User.lastSchedulefinished = scheduleNotification;
    if(User.qtsNewProposals > 0 || User.lastSchedulefinished != null){
      User.haveNotifications = true;
    }
    List canceledListJson = json['canceled'];
    if(canceledListJson.length > 0){
      User.canceled = true;
      canceledListJson.forEach((value) {
        User.scheduleListCanceled.add(CanceledSchedule.fromJson(value));
      });
    }else{
      User.canceled = false;
    }
  }
}

class NotificationResponse {
  Notification result;
  String error;

  NotificationResponse(this.result, this.error);

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    result = Notification.fromJson(json);
    error = "";
  }

  NotificationResponse.withError(String errorValue)
      : result = null,
  //
        error = errorValue;
}

class CanceledSchedule{
  DateTime talentCanceledDate;
  String talentCanceledName;

  CanceledSchedule({this.talentCanceledDate, this.talentCanceledName});

  CanceledSchedule.fromJson(Map<String, dynamic> json){
    talentCanceledDate = DateTime.parse(json['date']);
    talentCanceledName = json['talent']['talent'];
  }

}