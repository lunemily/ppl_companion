// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'environment.dart';
import 'login.dart';
import 'styles.dart';

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
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: () {},
                tooltip: 'About',
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: LoginWidget(),
        ),
      ),
    );
  }
}
