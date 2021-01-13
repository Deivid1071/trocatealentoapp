import 'package:trocatalentos_app/model/user.dart';

class Proposal {
  String providerId;
  String contractorId;
  int tcoin;
  int proposalId;
  String date;
  int talentId;
  String accepted;
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
    providerName = providerId == User.userId ? User.name : json['users_data'][0]['username'];
    //contractorName = contractorId == User.userId ? User.name : json['users_data'][1]['username'];
    providerAvatar= providerId == User.userId ? User.image : json['users_data'][0]['avatar'];
    //contractorAvatar = contractorId == User.userId ? User.image : json['users_data'][1]['avatar'];

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

