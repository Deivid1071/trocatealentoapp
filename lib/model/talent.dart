class Talent {
  int talentId;
  String talentTitle;
  String userTalentId;
  String userName;
  String userEmail;
  int tcoin;
  String avatar;
  String descricao;
  String banner;
  int avaliacao;


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

  Talent.fromJsonToDetail(Map<String, dynamic> json){
    talentTitle = json['talent'];
    banner = json['banner'];
    avaliacao = json['rating'];
    descricao = json['description'];
    talentId = json['id'];
    userTalentId = json['user'];
  }
}

class TalentResponse {
  List<Talent> resultListTalents = [];
  Talent resultDetailTalent;
  String error;

  TalentResponse(this.resultListTalents, this.error, this.resultDetailTalent);

  TalentResponse.fromJson(List<dynamic> json) {
    json.forEach((value) {
      resultListTalents.add(Talent.fromJson(value));
    });
    error = "";
  }

  TalentResponse.fromJsonToDetail(Map<String, dynamic> json) {
    resultDetailTalent = Talent.fromJsonToDetail(json);
    error = "";
  }

  TalentResponse.withError(String errorValue)
      : resultListTalents = null,
        //
        error = errorValue;
}
