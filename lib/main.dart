import 'package:flutter/material.dart';
import 'package:weather/screens/get_api_key.dart';
import 'package:weather/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pogoda',
      theme: ThemeData(
        fontFamily: 'Comfortaa',
        primaryColor: Colors.white,
        accentColor: Color.fromRGBO(255, 182, 185, 1),
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.grey),
          headline: TextStyle(color: Colors.black),

        ),
      ),
      home: FutureBuilder(
        future: isLogged(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return snapshot.data;
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<Widget> isLogged() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String result = prefs.getString('apiKey');
  if(result != null && result != ''){
    return MainScreen();
    // return false;
  }else{
    return GetApiKey();
    // return true;
  }
}