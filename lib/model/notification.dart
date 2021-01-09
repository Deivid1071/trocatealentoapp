import 'package:trocatalentos_app/model/proposal.dart';
import 'package:trocatalentos_app/model/schedule.dart';

class Notification {
  List<Proposal> proposalList = [];
  List<Schedule> scheduleList = [];

  Notification({this.proposalList, this.scheduleList});

  Notification.fromJson(Map<String, dynamic> json) {
    List<dynamic> proposalListJson = json['proposals'];
    proposalListJson.forEach((value) {
      proposalList.add(Proposal.fromJson(value));
    });
    List<dynamic> scheduleListJson = json['schedules'];
    scheduleListJson.forEach((value) {
      scheduleList.add(Schedule.fromJson(value));
    });
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
