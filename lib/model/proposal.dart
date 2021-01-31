import 'package:trocatalentos_app/model/user.dart';

class Proposal {
  String providerId;
  String contractorId;
  int tcoin;
  int proposalId;
  String date;
  int talentId;
  String accepted;
  String contractorIdUser;
  String providerIdUser;
  String providerName;
  String contractorName;
  String providerAvatar;
  String contractorAvatar;

  Proposal(
      {this.providerId,
      this.contractorId,
      this.tcoin,
      this.proposalId,
      this.date,
      this.providerName,
      this.contractorName,
      this.providerAvatar,
      this.contractorAvatar,
      });

  Proposal.fromJson(Map<String, dynamic> json){
    providerId = json['id_provider'];
    contractorId = json['id_contractor'];
    tcoin = json['tcoin'];
    proposalId = json['id'];
    date = json['date'];
    talentId = json['talentId'];
    accepted = json['accepted'];
    contractorIdUser = json['users_data'][1]['id'];
    providerIdUser = json['users_data'][0]['id'];
    providerName = json['users_data'][providerIdUser == providerId ? 0 : 1]['username'];
    contractorName = json['users_data'][contractorIdUser == contractorId ? 1 : 0]['username'];
    providerAvatar=  json['users_data'][providerIdUser == providerId ? 0 : 1]['avatar'];
    contractorAvatar = json['users_data'][contractorIdUser == contractorId ? 1 : 0]['avatar'];
  }

}

class ProposalResponse {
   List<Proposal> result=[];
   String error;

  ProposalResponse(this.result, this.error);

  ProposalResponse.fromJson(List<dynamic> json){
    json.forEach((value) {
      result.add(Proposal.fromJson(value));
    });
    error = "";
  }


  ProposalResponse.withError(String errorValue)
      : result = null,//
        error = errorValue;
}

