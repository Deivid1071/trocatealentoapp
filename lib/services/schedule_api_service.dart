import 'dart:async';
import 'dart:convert';

import 'package:trocatalentos_app/model/proposal.dart';
import 'package:trocatalentos_app/model/schedule.dart';
import 'package:trocatalentos_app/model/user.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

class ScheduleApiService {
  final String _baseUrl = environment['baseUrl'];
  String authToken = User.token.replaceAll('"', '').trim();

  Future<ScheduleResponse> getScheduleData() async {

    try {
      final response = await http
          .get("$_baseUrl/schedules/${User.userId}",
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
          return ScheduleResponse.fromJson(json.decode(response.body));
          break;
        case 400:
          return ScheduleResponse.withError(json.decode(response.body));
          break;
        default:
          return ScheduleResponse.withError(
              "${response.statusCode}: ${response.body}");
          break;
      }
    } on TimeoutException catch (e) {
      return ScheduleResponse.withError("Tempo de conexão expirado, por favor tente novamente");
    } catch (e) {
      return ScheduleResponse.withError("ERROR: $e");
    }
  }

  Future<String> createSchedule(String userTalentId, String date) async {
    try {
      final response = await http
          .post("$_baseUrl/schedule",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            "Authorization": "Bearer $authToken"
          },
          body: jsonEncode(<String, dynamic>{
            'id_provider': userTalentId,
            'id_contractor': User.userId,
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

}