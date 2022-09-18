import 'package:flutter/material.dart';
import 'package:ppl_companion/utils/api.dart';

import '../utils/styles.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late Future<bool> futureLogin;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
          if (constraints.maxWidth > 400) {
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
          width: 270,
          child: _buildForMobile(context),
        ),
      ],
    );
  }

  Widget _buildForMobile(BuildContext context) {
    return Center(
      child: Card(child: _loginForm(context)),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 8,
            ),
            child: Center(
              child: Text(
                'Please sign In',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                hintText: 'ashketchum',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Pikachu96',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: TextButton(
              style: Styles.flatButtonStyle,
              onPressed: () {
                login(nameController.text, passwordController.text, () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  'Sign In',
                  style: Styles.flatButtonTextStyle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: <Widget>[
                const Text('New to PPL?'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Create Account',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> login(
      String username, String password, VoidCallback onSuccess) async {
    await LoginApi.login(username, password);
    onSuccess.call();
  }
}
