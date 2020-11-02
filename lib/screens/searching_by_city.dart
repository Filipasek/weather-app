import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/getters/get_stations_list.dart';
// import 'package:weather/main.dart';
import 'package:weather/models/station_list_model.dart';
import 'package:weather/screens/main_screen.dart';
import 'package:geocoder/geocoder.dart';

class SearchByCity extends StatefulWidget {
  @override
  _SearchByCityState createState() => _SearchByCityState();
}

class _SearchByCityState extends State<SearchByCity> {
  bool loading = false;
  int _distance = 10;
  int _number = 5;

  String selected;
  Future<StationList> stations;
  @override
  void initState() {
    _getPickedStation();
    // setState(() {
    //   stations = getStationsList();
    // });
    super.initState();
  }

  _getPickedStation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> result = prefs.getStringList('station');

    setState(() {
      selected = result == null ? '' : result[0] ?? '';
    });
  }

  _savePickedStation(
      {@required String stationId, @required String city}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('station', [stationId, city]);
    await Future.delayed(Duration(milliseconds: 200));
  }

  _removePickedStation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('station');
    await Future.delayed(Duration(milliseconds: 200));
  }

  Future<String> _searchForCity(String query) async {
    // print('Query: ' + query);
    // var addresses = await Geocoder.google('AIzaSyALdSj4uj_vcNPEHDGmXbcbD0aTI9uUX8U', language: 'PL').findAddressesFromQuery(query);
    // var first = addresses.first;
    // print("${first.featureName} : ${first.coordinates}");
    // final query = "Wadowice";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    print("${first.featureName} : ${first.coordinates}");
    return first.coordinates.toString();
  }

  bool extreme = false;
  String searchQuery = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Zmień stację pomiarową",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Theme.of(context).accentColor,
                    ),
                    child: TextField(
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline5.color),
                      showCursor: true,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: Theme.of(context).accentColor,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: Theme.of(context).textTheme.headline5.color,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Theme.of(context).textTheme.headline5.color,
                        ),
                        labelText: "Miejscowość",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).textTheme.headline5.color,
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (text) {
                        setState(() {
                          searchQuery = text;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            searchQuery.length >= 3
                ? FutureBuilder(
                    future: _searchForCity(searchQuery),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data);
                      } else {
                        return Text('No data yet');
                      }
                    },
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
