// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class Data {
  static String pplEvent = 'West';
  static String pplTitle = 'PPL \'22 ${pplEvent.toLowerCase()}';
  static String titleFontFamily = 'TheBoldFont';
  static MaterialColor primaryColor = createMaterialColor(
    const Color.fromRGBO(4, 0, 128, 1),
  );

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

class Styles {
  static ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Data.primaryColor,
    minimumSize: const Size.fromHeight(36),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );
  static TextStyle flatButtonTextStyle = const TextStyle(
    fontFamily: 'Roboto',
    color: Colors.white,
    fontSize: 24,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Data.pplTitle,
      theme: ThemeData(
        primarySwatch: Data.primaryColor,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: Data.titleFontFamily,
            color: Colors.white,
            fontSize: 32,
          ),
          headlineSmall: TextStyle(
            fontFamily: Data.titleFontFamily,
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
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: () {},
                tooltip: 'About',
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Login(),
        ),
      ),
    );
  }
}
