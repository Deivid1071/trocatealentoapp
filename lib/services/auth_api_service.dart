import 'dart:async';
import 'dart:convert';
import 'package:trocatalentos_app/model/user.dart';
import '../config.dart';
import 'package:http/http.dart' as http;

class AuthorizationApiService {
  final String _baseUrl = environment['baseUrl'];

  Future<UserResponse> authorize(String email, String password) async {
    print(email);
    print(password);
    try {
      final response = await http
          .post("$_baseUrl/auth",
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Accept': 'application/json'
              },
              body: jsonEncode(<String, dynamic>{
                'email': email,
                'password': password,
              }))
          .timeout(const Duration(seconds: 10));

      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          //crypto(password, email);

          return UserResponse.fromJson(json.decode(response.body));
          break;
        case 400:
          return UserResponse.withError(json.decode(response.body));
          break;
        default:
          return UserResponse.withError(
              "${response.statusCode}: ${response.body}");
          break;
      }
    } on TimeoutException catch (e) {
      return UserResponse.withError("Tempo de conexão expirado, por favor tente novamente");
    } catch (e) {
      return UserResponse.withError("ERROR: $e");
    }
  }


  Future<UserResponse> register(String name, String email, String password) async {
    try {
      final response = await http
          .post("$_baseUrl/users",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            'username': name,
            'email': email,
            'password': password,

          }))
          .timeout(const Duration(seconds: 10));

      print(response.statusCode);
      print(json.decode(response.body));
      switch (response.statusCode) {
        case 200:
          return UserResponse.fromJsonRegister(json.decode(response.body));
          break;
        case 400:
          return UserResponse.withError(json.decode(response.body));
          break;
        default:
          return UserResponse.withError(
              "${response.statusCode}: ${response.body}");
          break;
      }
    } on TimeoutException catch (e) {
      return UserResponse.withError("Tempo de conexão expirado, por favor tente novamente");
    } catch (e) {
      return UserResponse.withError("ERROR: $e");
    }
  }

/*crypto(String password, String email)  {
    final EncryptedSharedPreferences encryptedSharedPreferences =
    EncryptedSharedPreferences();

    encryptedSharedPreferences
        .setString('senha', password)
        .then((bool success) {
      if (success) {
        print('success');
        encryptedSharedPreferences
            .getString('senha')
            .then((String _value) {
        });
      } else {
        print('fail');
      }
    });

    encryptedSharedPreferences
        .setString('email', email)
        .then((bool success) {
      if (success) {
        print('success');
        encryptedSharedPreferences
            .getString('email')
            .then((String _value) {
        });
      } else {
        print('fail');
      }
    });

  }*/
}
