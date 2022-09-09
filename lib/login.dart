import 'package:flutter/material.dart';

import 'api.dart';
import 'models.dart';
import 'styles.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late Future<Login> futureLogin;

  @override
  void initState() {
    super.initState();
    futureLogin = LoginApi.login("username", "password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 400) {
            return _buildForDesktop(context);
          } else {
            return _buildForMobile(context);
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                hintText: 'ashketchum96',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Pikachu',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: TextButton(
              style: Styles.flatButtonStyle,
              onPressed: () {},
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
          FutureBuilder<Login>(
            future: futureLogin,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.loginId);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}
