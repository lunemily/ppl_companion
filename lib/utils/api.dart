import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ppl_companion/utils/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'environment.dart';

class ApiBase {
  Map<String, String> getHeaders() {
    return {"PPL-Event": Data.pplEvent};
  }
}

class LoginApi extends ApiBase {
  static Future<bool> login(String username, String password) async {
    Map<String, String> loginHeaders = ApiBase().getHeaders();

    // loginHeaders.putIfAbsent("Content-Type", () => "application/json");

    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encodedCredentials = stringToBase64.encode("$username:$password");
    loginHeaders.putIfAbsent(
      "Authorization",
      () => "Basic $encodedCredentials",
    );

    try {
      final response = await http.post(
        Uri.parse("${Data.apiBaseUrl}/login"),
        headers: loginHeaders,
      );

      if (response.statusCode == 200) {
        Login login = Login.fromJson(jsonDecode(response.body));

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(Prefs.login.name, login.toJsonString());

        return true;
      } else {
        throw Exception('Failed to login');
      }
    } on Exception catch (_) {
      throw Exception(_);
    }
  }
}
