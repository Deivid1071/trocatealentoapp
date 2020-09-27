class Talent {
  int talentId;
  String talentTitle;
  String userTalentId;
  String userName;
  String userEmail;
  int tcoin;
  String avatar;

  Talent({
    this.talentId,
    this.talentTitle,
    this.userTalentId,
    this.userName,
    this.userEmail,
    this.tcoin,
    this.avatar,
  });

  Talent.fromJson(Map<String, dynamic> json) {
    talentId = json['id'];
    talentTitle = json['talent'];
    userTalentId = json['user']['id'];
    userName = json['user']['username'];
    userEmail = json['user']['email'];
    tcoin = json['user']['tcoin'];
    avatar = json['user']['avatar'];
  }
}

class TalentResponse {
  List<Talent> result = [];
  String error;

  TalentResponse(this.result, this.error);

  TalentResponse.fromJson(List<dynamic> json) {
    json.forEach((value) {
      result.add(Talent.fromJson(value));
    });
    error = "";
  }

  TalentResponse.withError(String errorValue)
      : result = null,
        //
        error = errorValue;
}
