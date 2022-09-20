import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:ppl_companion/utils/api.dart';
import 'package:ppl_companion/utils/models.dart';

import '../utils/styles.dart';

class ConsoleWidget extends StatefulWidget {
  final Login login;
  const ConsoleWidget({Key? key, required this.login}) : super(key: key);

  @override
  State<ConsoleWidget> createState() => _ConsoleWidgetState(login);
}

class _ConsoleWidgetState extends State<ConsoleWidget> {
  Login login;
  _ConsoleWidgetState(this.login);
  late Future<Challenger> challenger;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    challenger = ChallengerApi.getChallenger(login.loginId);
  }

  @override
  Widget build(BuildContext context) {
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
                  return Text('${snapshot.error}');
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
              const Text('Change your display name here:'),
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
                  login.loginId,
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
