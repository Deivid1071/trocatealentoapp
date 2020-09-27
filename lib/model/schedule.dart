class Schedule {
  String providerId;
  String contractorId;
  int tcoin;
  int scheduleId;
  String date;

  Schedule({this.providerId,this.contractorId, this.tcoin,this.scheduleId,this.date});

  Schedule.fromJson(Map<String, dynamic> json){
    providerId = json['id_provider'];
    contractorId = json['id_contractor'];
    tcoin = json['tcoin'];
    scheduleId = json['id'];
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

