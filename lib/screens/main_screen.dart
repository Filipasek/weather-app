import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/getters/weather_data.dart';
import 'package:weather/models/weather_data_model.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<WeatherData> weatherData;
  @override
  void initState() {
    setState(() {
      weatherData = getWeatherData();
    });
    super.initState();
  }

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
      future: weatherData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // int temp = snapshot.data.temperature;
          String stime = snapshot.data.time;
          String time =
              stime.substring(stime.indexOf("T") + 1, stime.indexOf("T") + 6);
          return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                title: Text('Ostatnia aktualizacja: $time', style: TextStyle(),),
              ),
              body: Center(
            // child: Text('Temperatura: $temp°C'),
            child: Text(stime),
          ));
        } else {
          return Center(
            child: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.grey,
            ),
          );
        }
      },
    );
  }
}
