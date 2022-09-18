import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    authenticated = checkLogin();
  }

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(Prefs.login.name);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: authenticated,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            return const Text("Authenticated");
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
