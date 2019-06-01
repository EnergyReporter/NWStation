import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class GenericListPage extends StatelessWidget {
  GenericListPage();

  String getPageName();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
