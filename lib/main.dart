import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sokari | Flutter Interview',
      theme: ThemeData(
          primaryTextTheme:
              const TextTheme(labelLarge: TextStyle(color: Colors.grey)),
          fontFamily: "Euclid",
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.orange,
              primary: Colors.orange,
              secondary: Colors.grey),
          highlightColor: Colors.orange),
      home: const MyHomePage(title: 'Akwa Ibom'),
    );
  }
}
