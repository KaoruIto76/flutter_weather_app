import 'package:flutter/material.dart';
import 'package:flutter_weather_app/pages/home.dart';

void main() { runApp(MyApp()); }
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => new Home(),
      },
    );
  }
}
