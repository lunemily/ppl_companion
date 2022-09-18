import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Text(login.token);
  }
}
