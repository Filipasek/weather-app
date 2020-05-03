import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/screens/get_api_key.dart';

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
                    color: Theme.of(context).textTheme.body1.color,
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
            // Container(
            //   margin: EdgeInsets.only(bottom: 20.0),
            //   height: 50.0,
            //   width: double.infinity,
            //   child: RaisedButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (_) => GetApiKey()),
            //       );
            //     },
            //     color: Color.fromRGBO(0, 191, 166, 1),
            //     child: Text(
            //       "Zmień lokalizację",
            //       style: TextStyle(
            //         fontSize: 20.0,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
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
