import 'package:flutter/material.dart';
import 'package:corona_tracker/splash_screen.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

// void main() {
//   runApp(
//     DevicePreview(
//       builder: (context) => MyApp(),
//       enabled: !kReleaseMode,
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}
