import 'package:flutter/material.dart';
import 'package:weather/getters/weather_data.dart';
import 'package:weather/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future weatherData;
  @override
  void initState() {
    setState(() {
      weatherData = getWeatherData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: weatherData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.statusCode == 200) {
            String stime = snapshot.data.time;
            String hour = (int.parse(stime.substring(
                        stime.indexOf("T") + 1, stime.indexOf("T") + 3)) +
                    2)
                .toString();
            String minute =
                stime.substring(stime.indexOf("T") + 4, stime.indexOf("T") + 6);
            String time = '$hour:$minute';

            int temp = snapshot.data.temperature;
            String temptext = temp.toString() + "°"; // temperature
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    // setState(() {
                    // weatherData = getWeatherData();

                    // });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainScreen(),
                      ),
                    );
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SettingsScreen(
                            requestsLeft: snapshot.data.requestsLeft,
                            totalRequests: snapshot.data.requestsPerDay,
                          ),
                        ),
                      );
                    },
                  ),
                ],
                centerTitle: true,
                elevation: 0,
                title: Text(
                  'Dane z $time',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              snapshot.data.description,
                              style: TextStyle(
                                fontSize: 20.0,
                                color:
                                    Theme.of(context).textTheme.headline5.color,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              snapshot.data.advice,
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          Text(
                            temptext,
                            style: TextStyle(
                              fontFamily: 'quicksand',
                              color:
                                  Theme.of(context).textTheme.headline5.color,
                              fontSize: 80.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 50.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, i) {
                          String text = "";
                          switch (i) {
                            case 0:
                              String btext = snapshot.data.pressure.toString();
                              text = "Ciśnienie: $btext\hPa";
                              break;
                            case 1:
                              String btext = snapshot.data.humidity.toString();
                              text = "Wilgotność: $btext\%";
                              break;
                            case 2:
                              String btext = snapshot.data.pm25.toString();
                              text = "PM25: $btext\µg/m³";
                              break;
                            case 3:
                              String btext = snapshot.data.pm10.toString();
                              text = "PM10: $btext\µg/m³";
                              break;
                            case 4:
                              String btext = snapshot.data.pm1.toString();
                              text = "PM1: $btext\µg/m³";
                              break;
                          }
                          return Container(
                            height: 50.0,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Center(
                              child: Text(
                                text,
                                style: TextStyle(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            int code = snapshot.data.statusCode;
            String message = snapshot.data.errorMessage;
            return Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.settings),
                    color: Theme.of(context).textTheme.headline5.color,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
                centerTitle: true,
                elevation: 0,
                // title: Text(
                //   'Dane z $time',
                //   style: TextStyle(
                //     fontSize: 12.0,
                //     color: Theme.of(context).textTheme.bodyText2.color,
                //   ),
                // ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              body: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Wystąpił błąd!\n"),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Kod błędu: $code\n"),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Błąd: $message\n"),
                    ),
                    code == 401
                        ? Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "Nieprawidłowy klucz API. Wejdź w ustawienia, aby zmienić na prawidłowy."),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            );
          }
        } else {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
              centerTitle: true,
              elevation: 0,
            ),
            body: Center(
                child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Color.fromRGBO(0, 191, 166, 1)),
            )),
          );
        }
      },
    );
  }
}
