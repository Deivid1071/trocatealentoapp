import 'dart:async';
import 'dart:convert';

import 'package:trocatalentos_app/model/proposal.dart';
import 'package:trocatalentos_app/model/user.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

class ProposalApiService {
  final String _baseUrl = environment['baseUrl'];
  String authToken = User.token.replaceAll('"', '').trim();

  Future<ProposalResponse> getProposalData() async {

    try {
      final response = await http
          .get("$_baseUrl/proposal/${User.userId}",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            "Authorization": "Bearer $authToken"
          },
          )
          .timeout(const Duration(seconds: 10));

      print(response.statusCode);
      print(json.decode(response.body));
      switch (response.statusCode) {
        case 200:

          return ProposalResponse.fromJson(json.decode(response.body));
          break;
        case 400:
          return ProposalResponse.withError(json.decode(response.body));
          break;
        default:
          return ProposalResponse.withError(
              "${response.statusCode}: ${response.body}");
          break;
      }
    } on TimeoutException catch (e) {
      return ProposalResponse.withError("Tempo de conexão expirado, por favor tente novamente");
    } catch (e) {
      return ProposalResponse.withError("ERROR: $e");
    }
  }

  Future<String> createProposal(String userTalentId, String date, int tcoin, int talentId) async {
    try {
      final response = await http
          .post("$_baseUrl/proposal",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            "Authorization": "Bearer $authToken"
          },
          body: jsonEncode(<String, dynamic>{
            'id_provider': userTalentId,
            'id_contractor': User.userId,
            'talentId': talentId,
            'tcoin': tcoin,
            'date': date,

          }))
          .timeout(const Duration(seconds: 10));

      print(response.statusCode);
      //print(json.decode(response.body));
      switch (response.statusCode) {
        case 200:
          return '200';
          break;
        case 400:
          return json.decode(response.body).toString();
          break;
        default:
          return "${response.statusCode}: ${response.body}";
          break;
      }
    } on TimeoutException catch (e) {
      return "Tempo de conexão expirado, por favor tente novamente";
    } catch (e) {
      return "ERROR: $e";
    }
  }

  Future<String> acceptProposal(String proposalId) async {
    try {
      final response = await http
          .patch("$_baseUrl/accept/$proposalId",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            "Authorization": "Bearer $authToken"
          },
          body: jsonEncode(<String, dynamic>{
            'accepted': true,
          }))
          .timeout(const Duration(seconds: 10));

      print(response.statusCode);
      //print(json.decode(response.body));
      switch (response.statusCode) {
        case 200:
          return '200';
          break;
        case 400:
          return json.decode(response.body).toString();
          break;
        default:
          return "${response.statusCode}: ${response.body}";
          break;
      }
    } on TimeoutException catch (e) {
      return "Tempo de conexão expirado, por favor tente novamente";
    } catch (e) {
      return "ERROR: $e";
    }
  }

}