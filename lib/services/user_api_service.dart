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
    ///dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers["authorization"] = "Bearer ${authToken}";
    FormData data = FormData.fromMap({
        "file": image != null ? await MultipartFile.fromFile(
        image.path) : null,
        "username": name,
        "email": email,
        "password": password,
        "age": age,
    },);
    try {
      final response = await dio
          .patch("$_baseUrl/user/${User.userId}", data: data)
          .timeout(const Duration(seconds: 10));

      print(response.statusCode);
      //print(json.decode(response.body));
      switch (response.statusCode) {
        case 200:
          User.image = '${response.data['avatar']}';
          return '200';
          break;
        case 400:
          return '${response.statusCode}';
          break;
        default:
          return
              "${response.statusCode}: ${response.data}";
          break;
      }
    } on TimeoutException catch (e) {
      return "Tempo de conexão expirado, por favor tente novamente";
    } catch (e) {
      return "ERROR: $e";
    }
  }


}