import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/station_list_model.dart';
import 'package:geocoder/geocoder.dart';
import 'package:weather/screens/select_custom_station.dart';

class SearchByCity extends StatefulWidget {
  @override
  _SearchByCityState createState() => _SearchByCityState();
}

class _SearchByCityState extends State<SearchByCity> {

  String selected;
  Future<StationList> stations;
  @override
  void initState() {
    _getPickedStation();
    super.initState();
  }

  _getPickedStation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> result = prefs.getStringList('station');

    setState(() {
      selected = result == null ? '' : result[0] ?? '';
    });
  }

  // _getGoogleAddress(address) async {
  //   const _host = 'https://maps.google.com/maps/api/geocode/json';
  //   const apiKey = '';
  //   var encoded = Uri.encodeComponent(address);
  //   final uri = Uri.parse('$_host?key=$apiKey&address=$encoded');

  //   http.Response response = await http.get(uri);
  //   final responseJson = json.decode(response.body);
  //   print(responseJson['results'][0]['geometry']['location']);
  // }

  Future<List<Address>> _searchForCity(String query) async {
    List<Address> addresses =
        await Geocoder.local.findAddressesFromQuery(query);
    Address first = addresses.first;
    print("${first.featureName} : ${first.coordinates}");
    return addresses;
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
          "Wyszukaj po adresie",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
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
                      onChanged: (text) {
                        setState(() {
                          searchQuery = text;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: searchQuery.length >= 3
                  ? FutureBuilder(
                      future: _searchForCity(searchQuery),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<Address> addresses = snapshot.data;

                          return ListView.builder(
                            itemCount: addresses.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Container(
                                width: double.infinity,
                                margin:
                                    EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                                height: 120.0,
                                child: RaisedButton(
                                  disabledColor: Theme.of(context).accentColor,
                                  disabledTextColor: Colors.black,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .color,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.all(5.0),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PickStation(
                                          lat:
                                              addresses[i].coordinates.latitude,
                                          lng: addresses[i]
                                              .coordinates
                                              .longitude,
                                          cityName: addresses[i].addressLine,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(addresses[i].addressLine),
                                      Text(addresses[i].adminArea),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Text('Niestety, nie mogliśmy nic znaleźć');
                        }
                      },
                    )
                  : Text('Podaj co najmniej 3 znaki'),
            ),
          ],
        ),
      ),
    );
  }
}
