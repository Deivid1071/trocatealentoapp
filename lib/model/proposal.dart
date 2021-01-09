class Proposal {
  String providerId;
  String contractorId;
  int tcoin;
  int proposalId;
  String date;
  int talentId;
  bool accepted;

  Proposal(this.providerId,this.contractorId, this.tcoin,this.proposalId,this.date);

  Proposal.fromJson(Map<String, dynamic> json){
    providerId = json['id_provider'];
    contractorId = json['id_contractor'];
    tcoin = json['tcoin'];
    proposalId = json['id'];
    date = json['date'];
    talentId = json['talentId'];
    accepted = json['accepted'];
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

