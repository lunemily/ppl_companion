import 'package:flutter/material.dart';

class Styles {
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

  static ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Styles.primaryColor,
    minimumSize: const Size.fromHeight(36),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );

  static ButtonStyle strokedButtonStyle = TextButton.styleFrom(
    foregroundColor: Styles.primaryColor,
    backgroundColor: Colors.white,
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
