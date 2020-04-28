import 'package:flutter/material.dart';
import 'package:weather/screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Color.fromRGBO(255, 182, 185, 1),
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.grey),
          headline: TextStyle(color: Colors.black),
        ),
      ),
      home: MainScreen(),
    );
  }
}