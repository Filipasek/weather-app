import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/screens/get_api_key.dart';
import 'package:weather/screens/select_custom_station.dart';
import 'package:weather/tools/config.dart';

class SettingsScreen extends StatefulWidget {
  final String requestsLeft;
  final String totalRequests;

  SettingsScreen({
    this.requestsLeft,
    this.totalRequests,
  });
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    String requests = widget.requestsLeft;
    String total = widget.totalRequests;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: requests != null && total != null
            ? Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Pozostałe zapytania: $requests/$total",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                ),
              )
            : Text("Ustawienia"),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(50.0),
              child: Image.asset('assets/credentials/airly.png'),
            ),
            Theme(
              data: ThemeData(
                unselectedWidgetColor:
                    Theme.of(context).textTheme.headline5.color,
              ),
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: CheckboxListTile(
                  activeColor: Theme.of(context).accentColor,
                  checkColor: Colors.white,
                  title: Text(
                    'Kolorowy wskaźnik',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline5.color,
                    ),
                  ),
                  value: Provider.of<ConfigData>(context).weatherLight,
                  onChanged: (newValue) {
                    Provider.of<ConfigData>(context, listen: false)
                        .changeWeatherLightBoolean(newValue);
                  },
                ),
              ),
            ),
            Theme(
              data: ThemeData(
                unselectedWidgetColor:
                    Theme.of(context).textTheme.headline5.color,
              ),
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: CheckboxListTile(
                  activeColor: Theme.of(context).accentColor,
                  checkColor: Colors.white,
                  title: Text(
                    'Pokaż wykres',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline5.color,
                    ),
                  ),
                  value: Provider.of<ConfigData>(context).showChart,
                  onChanged: (newValue) {
                    Provider.of<ConfigData>(context, listen: false)
                        .changeShowChartBoolean(newValue);
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              height: 50.0,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PickStation()),
                  );
                },
                color: Color.fromRGBO(0, 191, 166, 1),
                child: Text(
                  "Zmień stację",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50.0),
              height: 50.0,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => GetApiKey()),
                  );
                },
                color: Color.fromRGBO(0, 191, 166, 1),
                child: Text(
                  "Zmień klucz API",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
