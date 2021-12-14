import 'package:flutter/material.dart';

class Myconstant {
  // field
  static String appName = 'Comp Uber';
  static Color primary = const Color(0xff00c2cb);
  static Color light = const Color(0xff0097a7);
  static Color dark = const Color(0xff004d40);

  // method
  BoxDecoration planBox() => BoxDecoration(color: primary);

  BoxDecoration whiteBox() => BoxDecoration(color: Colors.white54);

  BoxDecoration gradienBox() => BoxDecoration(
        gradient: RadialGradient(center: Alignment(0, -0.5),
          radius: 0.9,
          colors: [Colors.white, primary],
        ),
      );

  TextStyle h1Style() =>
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: dark);

  TextStyle h2Style() =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: dark);

  TextStyle h3Style() =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: dark);
}
