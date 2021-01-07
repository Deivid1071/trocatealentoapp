import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'package:dio/dio.dart';
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

  Future<TalentResponse> createTalent345(String titulo, String descricao) async {
    try {
      final response = await http
          .post("$_baseUrl/talent",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            "Authorization": "Bearer $authToken"
          },
          body: jsonEncode(<String, dynamic>{
            'userId': User.userId,
            'talent': titulo,
            'description': descricao,

          }))
          .timeout(const Duration(seconds: 10));

      print(response.statusCode);
      //print(json.decode(response.body));
      switch (response.statusCode) {
        case 200:
          return TalentResponse.fromJsonToDetail(json.decode(response.body));
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

  Future createTalent(File banner, String titulo, String descricao, String tcoin) async {
    Dio dio = new Dio();
    ///dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers["authorization"] = "Bearer ${authToken}";
    FormData data = FormData.fromMap({
      "file": banner != null ? await MultipartFile.fromFile(
          banner.path) : null,
      "userId": User.userId,
      "talent": titulo,
      "description": descricao,
      "tcoin": tcoin,
    },);
    try {
      final response = await dio
          .post("$_baseUrl/talent", data: data)
          .timeout(const Duration(seconds: 10));

      print(response.statusCode);
      //print(json.decode(response.body));
      switch (response.statusCode) {
        case 200:
          return '${response.statusCode}';
          break;
        case 400:
          return '${response.statusCode}';
          break;
        default:
          return
            "${response.statusCode}: ${response}";
          break;
      }
    } on TimeoutException catch (e) {
      return "Tempo de conexão expirado, por favor tente novamente";
    } catch (e) {
      return "ERROR: $e";
    }
  }

  Future<TalentResponse> getTalentById(String id) async {
    try {
      final response = await http
          .get("$_baseUrl/talent/detail/$id",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          "Authorization": "Bearer $authToken"
        },
      )
          .timeout(const Duration(seconds: 10));

      //print(response.statusCode);
      print(json.decode(response.body));
      switch (response.statusCode) {
        case 200:
          return TalentResponse.fromJsonToDetail(json.decode(response.body));
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