import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/main.dart';

class GetApiKey extends StatefulWidget {
  @override
  _GetApiKeyState createState() => _GetApiKeyState();
}

_launchURL() async {
  const url = 'https://developer.airly.eu/login';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_saveApiKey(String _key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('apiKey', _key);
}

class _GetApiKeyState extends State<GetApiKey> {
  final _formKey = GlobalKey<FormState>();
  String _apiKey;
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      "Witaj!",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 60.0,
                        color: Theme.of(context).textTheme.headline.color,
                      ),
                    ),
                  ),
                  Text(
                    'Aby móc korzystać z tej aplikacji, musisz się zalogować.\n\nBy to zrobić, wejdź na stronę developer.airly.eu/login klikając w przycisk "Przejdź do logowania".\n\nPo zalogowaniu poszukaj napisu na ciemnym tle "Twój klucz API" bądź "Your API Key". Kliknij w niego, aby odsłonić klucz, który następnie skopiuj i wklej w tej aplikacji.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    width: double.infinity,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: _launchURL,
                      // color: Color.fromRGBO(0, 191, 166, 1),
                      // color: Color.fromRGBO(217,217,243,1),
                      // color: Color.fromRGBO(59,154,156,1),
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Przejdź do logowania",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
                      child: Theme(
                        data: ThemeData(
                          primaryColor: Theme.of(context).accentColor,
                        ),
                        child: TextFormField(
                          showCursor: false,
                          decoration: InputDecoration(
                            labelText: "Wprowadź klucz",
                            border: OutlineInputBorder(),
                          ),
                          validator: (input) => input.length < 5
                              ? "Podaj prawidłowy klucz"
                              : null,
                          onSaved: (input) => _apiKey = input,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _saveApiKey(_apiKey);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MyApp()),
                          );
                        }
                      },
                      color: Color.fromRGBO(0, 191, 166, 1),
                      child: Text(
                        "Zapisz klucz",
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
          ),
        ),
      ),
    );
  }
}
