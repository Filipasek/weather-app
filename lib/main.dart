import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          bodyText2: TextStyle(color: Colors.grey),
          headline5: TextStyle(color: Colors.black),
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Comfortaa',
        primaryColor: Color.fromRGBO(40, 44, 55, 1),
        accentColor: Color.fromRGBO(255, 182, 185, 1),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.grey),
          headline5: TextStyle(color: Colors.white),
        ),
      ),
      home: App(),
    );
  }
}
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).primaryColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return FutureBuilder(
        future: isLogged(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
  }
}
Future<Widget> isLogged() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String result = prefs.getString('apiKey');
  if (result != null && result != '') {
    return MainScreen();
    // return false;
  } else {
    return GetApiKey();
    // return true;
  }
}
