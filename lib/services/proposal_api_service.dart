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


}