import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ppl_companion/screens/console.dart';
import 'package:ppl_companion/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/models.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late Future<bool> authenticated;
  late Future<Login> login;

  @override
  void initState() {
    super.initState();
    authenticated = checkLogin();
  }

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(Prefs.login.name);
  }

  Future<Login> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return Login.fromJson(jsonDecode(prefs.getString(Prefs.login.name)!));
  }

  @override
  Widget build(BuildContext context) {
    // Return an asynchronous widget to gate check authentication.
    return FutureBuilder<bool>(
      future: authenticated,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            // Confirmed authenticated. Get the information and pass it to the console. We don't want to manage that API call here.
            login = getLogin();
            return FutureBuilder<Login>(
              future: login,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ConsoleWidget(
                    login: snapshot.data!,
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            );
          } else {
            return const LoginWidget();
          }
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
