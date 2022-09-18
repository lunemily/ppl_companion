import 'package:flutter/material.dart';
import 'package:ppl_companion/utils/api.dart';
import 'package:ppl_companion/utils/models.dart';

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

  @override
  void initState() {
    super.initState();
    challenger = ChallengerApi.getChallenger(login.loginId, login.token);
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
}
