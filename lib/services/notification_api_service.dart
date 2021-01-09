import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:trocatalentos_app/model/notification.dart';
import 'package:trocatalentos_app/model/user.dart';

import '../config.dart';

class NotificationApiService {
  final String _baseUrl = environment['baseUrl'];
  String authToken = User.token.replaceAll('"', '').trim();

  Future<NotificationResponse> getMyTalents() async {
    try {
      final response = await http
          .get("$_baseUrl/notifications/${User.userId}",
        headers: <String, String>{
          'Content-Type': 'application/json; ch  arset=UTF-8',
          'Accept': 'application/json',
          "Authorization": "Bearer $authToken"
        },
      )
          .timeout(const Duration(seconds: 10));

      print(response.statusCode);
      print(json.decode(response.body));
      switch (response.statusCode) {
        case 200:
          return NotificationResponse.fromJson(json.decode(response.body));
          break;
        case 400:
          return NotificationResponse.withError(json.decode(response.body));
          break;
        default:
          NotificationResponse.withError("${response.statusCode}: ${response.body}");
          break;
      }
    } on TimeoutException catch (e) {
      return NotificationResponse.withError("Tempo de conexão expirado, por favor tente novamente");
    } catch (e) {
      return NotificationResponse.withError("ERROR: $e");
    }
  }
}