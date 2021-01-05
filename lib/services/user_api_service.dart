import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:trocatalentos_app/model/user.dart';
import 'package:http/http.dart' as http;

import '../config.dart';


class UserApiService{
  final String _baseUrl = environment['baseUrl'];
  String authToken = User.token.replaceAll('"', '').trim();

  Future  updateUserPerfil(File image, String name, String email, String password, String age) async {
    Dio dio = new Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "token ${authToken}";
    FormData data = FormData.fromMap({
        "image": image != null ? await MultipartFile.fromFile(
        image.path,) : null,
        "username": name,
        "email": email,
        "password": password,
        "age": age,
    },);
    try {
      final response = await dio
          .post("$_baseUrl/user", data: data)
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


}