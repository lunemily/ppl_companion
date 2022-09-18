// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:ppl_companion/screens/home.dart';
import 'package:ppl_companion/screens/login.dart';
import 'package:ppl_companion/screens/sidenav.dart';

import 'utils/environment.dart';
import 'utils/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Data.pplTitle,
      theme: ThemeData(
        primarySwatch: Styles.primaryColor,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: Styles.titleFontFamily,
            color: Colors.white,
            fontSize: 32,
          ),
          headlineSmall: TextStyle(
            fontFamily: Styles.titleFontFamily,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      home: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/images/wallpaper-${Data.pplEvent.toLowerCase()}.png"),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(Data.pplTitle),
            toolbarHeight: 64,
          ),
          backgroundColor: Colors.transparent,
          drawer: const Sidenav(),
          body: const HomeWidget(),
        ),
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/login': (context) => const LoginWidget(),
      },
    );
  }
}
