import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ppl_companion/utils/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'environment.dart';

class ApiBase {
  Map<String, String> getHeaders() {
    return {
      "PPL-Event": Data.pplEvent,
    };
  }
}

class LoginApi extends ApiBase {
  static Future<bool> login(String username, String password) async {
    Map<String, String> headers = ApiBase().getHeaders();

    // headers.putIfAbsent("Content-Type", () => "application/json");

    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encodedCredentials = stringToBase64.encode("$username:$password");
    headers.putIfAbsent(
      "Authorization",
      () => "Basic $encodedCredentials",
    );

    try {
      final response = await http.post(
        Uri.parse("${Data.apiBaseUrl}/login"),
        headers: headers,
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
      // TODO: Make this throw out a toast message
      throw Exception(_);
    }
  }
}

class ChallengerApi extends ApiBase {
  static Future<Map<String, String>> getAuthenticatedHeaders() async {
    Map<String, String> headers = ApiBase().getHeaders();
    var prefs = await SharedPreferences.getInstance();
    String token =
        Login.fromJson(jsonDecode(prefs.getString(Prefs.login.name)!)).token;
    headers.putIfAbsent(
      "Authorization",
      () => "Bearer $token",
    );
    return headers;
  }

  static Future<Challenger> getChallenger(String loginId) async {
    try {
      final response = await http.get(
        Uri.parse("${Data.apiBaseUrl}/challenger/$loginId"),
        headers: await getAuthenticatedHeaders(),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }
        Challenger challenger = Challenger.fromJson(jsonDecode(response.body));
        return challenger;
      } else if (response.statusCode == 403) {
        throw BadAuthenticationException('Bad token. Please login again.');
      } else {
        throw Exception('Failed to get challenger');
      }
    } on Exception catch (_) {
      // TODO: Make this throw out a toast message
      throw Exception(_);
    }
  }

  static Future<bool> setName(String newName, String loginId) async {
    Map<String, String> headers = await getAuthenticatedHeaders();
    headers.putIfAbsent(
      'Content-Type',
      () => 'application/json; charset=UTF-8',
    );
    Map body = {'displayName': newName};
    try {
      final response = await http.post(
        Uri.parse('${Data.apiBaseUrl}/challenger/$loginId'),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }
        return true;
      } else {
        throw Exception('Failed to rename challenger');
      }
    } on Exception catch (_) {
      return false;
    }
  }
}

class BadAuthenticationException implements Exception {
  BadAuthenticationException(String message);
}
