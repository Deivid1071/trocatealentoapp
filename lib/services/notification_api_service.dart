import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:trocatalentos_app/model/notification.dart';
import 'package:trocatalentos_app/model/user.dart';

import '../config.dart';

class NotificationApiService {
  final String _baseUrl = environment['baseUrl'];
  String authToken = User.token.replaceAll('"', '').trim();

  Future<NotificationResponse> getMyNotifications() async {
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

  Future<String> sendRating(int rating, int talentId) async {
    try {
      final response = await http
          .post("$_baseUrl/finish/schedule/$talentId",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            "Authorization": "Bearer $authToken"
          },
          body: jsonEncode(<String, dynamic>{
            'rating': rating,
          }))
          .timeout(const Duration(seconds: 10));

      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          return '${response.statusCode}';
          break;
        case 400:
          return '${json.decode(response.body)}';
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