import 'dart:async';
import 'dart:convert';

import 'package:trocatalentos_app/model/proposal.dart';
import 'package:trocatalentos_app/model/schedule.dart';
import 'package:trocatalentos_app/model/talent.dart';
import 'package:trocatalentos_app/model/user.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

class TalentApiService {
  final String _baseUrl = environment['baseUrl'];
  String authToken = User.token.replaceAll('"', '').trim();

  Future<TalentResponse> getTalentBySearch(String search) async {

    try {
      final response = await http
          .get("$_baseUrl/talent/$search",
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
          return TalentResponse.fromJson(json.decode(response.body));
          break;
        case 400:
          return TalentResponse.withError(json.decode(response.body));
          break;
        default:
          return TalentResponse.withError(
              "${response.statusCode}: ${response.body}");
          break;
      }
    } on TimeoutException catch (e) {
      return TalentResponse.withError("Tempo de conexão expirado, por favor tente novamente");
    } catch (e) {
      return TalentResponse.withError("ERROR: $e");
    }
  }


}