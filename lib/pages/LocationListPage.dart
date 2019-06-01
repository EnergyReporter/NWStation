import 'package:flutter/material.dart';
import 'package:nw_station/auth/LoginButton.dart';
import 'package:nw_station/pages/GenericListPage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nw_station/store/TestCollection.dart';

class LocationListPage extends StatefulWidget {
  LocationListPage();

  @override
  _LocationListPageState createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  List<String> _locations = [];

  @override
  void initState() {
    super.initState();
    getFavorites('test').then((List<String> faves) {
      _locations = faves;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginButton(),
            new Text(
              "Locations",
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,
            ),
           new Text(
              "Hi !"+ (!_locations.isEmpty ? _locations.join(",") : "None found"),
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,
            ),
          ],
        ),
      ),
    );
  }
}
