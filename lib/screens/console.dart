import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:ppl_companion/utils/api.dart';
import 'package:ppl_companion/utils/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/styles.dart';

class ConsoleWidget extends StatefulWidget {
  const ConsoleWidget({Key? key}) : super(key: key);

  @override
  State<ConsoleWidget> createState() => _ConsoleWidgetState();
}

class _ConsoleWidgetState extends State<ConsoleWidget> {
  late Future<Login> login;
  late Future<Challenger> challenger;
  late String loginId;
  TextEditingController nameController = TextEditingController();

  @override
  initState() {
    login = getLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // First get the login "cookie"
    return FutureBuilder<Login>(
      future: login,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          loginId = snapshot.data!.loginId;
          // Now fetch the challenger data
          challenger = ChallengerApi.getChallenger(loginId);
          return buildConsole(context);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildConsole(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (
          BuildContext context,
          BoxConstraints constraints,
        ) {
          if (constraints.maxWidth > 600) {
            return _buildForDesktop(
              context,
            );
          } else {
            return _buildForMobile(
              context,
            );
          }
        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.up,
        child: const SizedBox(
            width: 36,
            height: 36,
            child: Icon(
              Icons.add,
              size: 36,
            )),
        children: [
          // FloatingActionButton.small(
          //   child: const Icon(Icons.qr_code),
          //   onPressed: () {},
          // ),
          FloatingActionButton.small(
            child: const Icon(Icons.edit),
            onPressed: () => editNameDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildForDesktop(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 400,
          child: _buildForMobile(context),
        ),
      ],
    );
  }

  Widget _buildForMobile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _nameCard(context),
      ],
    );
  }

// challenger = ChallengerApi.getChallenger(login.loginId);
  Widget _nameCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          child: Center(
            child: FutureBuilder<Challenger>(
              future: challenger,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Text(
                      "${snapshot.data!.displayName}'s Trainer Card",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }

  void editNameDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Wrap(
            children: [
              Text(
                'Update your display name?',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Display Name',
                    hintText: 'Ash Ketchum',
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: Styles.flatButtonStyle,
              onPressed: () {
                editName(
                  nameController.text,
                  loginId,
                  () => goHome(context),
                  () => actionFailed(context, 'Failed to change name'),
                );
              },
              child: const Text('Save'),
            ),
            TextButton(
              style: Styles.strokedButtonStyle,
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<Login> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return Login.fromJson(jsonDecode(prefs.getString(Prefs.login.name)!));
  }

  Future<void> editName(
    String username,
    String loginId,
    VoidCallback onSuccess,
    VoidCallback onFailure,
  ) async {
    bool result = await ChallengerApi.setName(username, loginId);
    if (result) {
      onSuccess.call();
    } else {
      onFailure.call();
    }
  }

  void goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false,
    );
  }

  Future actionFailed(BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
        );
      },
    );
  }
}
