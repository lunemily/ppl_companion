import 'package:flutter/material.dart';
import 'package:ppl_companion/screens/trainer_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/models.dart';

class Sidenav extends StatefulWidget {
  const Sidenav({Key? key}) : super(key: key);

  @override
  State<Sidenav> createState() => _SidenavState();
}

class _SidenavState extends State<Sidenav> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => goHome(context),
          ),
          ListTile(
            leading: const Icon(Icons.chrome_reader_mode),
            title: const Text('Trainer Card'),
            onTap: () => _navPush(
              context,
              const TrainerCard(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.videogame_asset),
            title: const Text('How to Challenge'),
            onTap: () => goHome(context),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('PPL Rules'),
            onTap: () => goHome(context),
          ),
          ListTile(
            leading: const Icon(Icons.stars),
            title: const Text('Prize Pools'),
            onTap: () => goHome(context),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              logout(context);
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> _navPush(BuildContext context, Widget page) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(Prefs.login.name);
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false,
    );
  }
}
