import 'package:flutter/material.dart';
import 'package:nw_station/auth/LoginButton.dart';
import 'package:nw_station/pages/GenericListPage.dart';

class LocationListPage extends GenericListPage {
  @override
  String getPageName() {
    return "Locations";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new LoginButton(),
            new Text(
              getPageName(),
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}
