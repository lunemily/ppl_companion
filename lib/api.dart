import 'dart:convert';

import 'package:ppl_companion/models.dart';

import 'environment.dart';

class ApiBase {
  Map<String, String> getHeaders() {
    return {"PPL-Event": Data.pplEvent};
  }
}

class LoginApi extends ApiBase {
  static Future<Login> login(String username, String password) async {
    Map<String, String> loginHeaders = ApiBase().getHeaders();

    loginHeaders.putIfAbsent("Content-Type", () => "application/json");

    String credentials = "$username:$password";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encodedCredentials = stringToBase64.encode(credentials);
    loginHeaders.putIfAbsent(
      "Authorization",
      () => "Basic $encodedCredentials",
    );

    // final response = await http.get(
    //   Uri.parse("${Data.apiBaseUrl}/login"),
    //   headers: loginHeaders,
    // );
    //
    // if (response.statusCode == 200) {
    //   return Login.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to login');
    // }

    Login login = const Login(
      loginId: "someLoginId",
      token: "someToken",
      isLeader: false,
      leaderId: "",
    );
    return login;
  }
}
