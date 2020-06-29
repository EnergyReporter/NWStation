import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LocationListPage extends StatefulWidget {
  String _userId;

  LocationListPage(this._userId);

  @override
  _LocationListPageState createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('users/${widget._userId}/locations')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Center(child: new CircularProgressIndicator());
              default:
                return new ListView(children: getLocations(snapshot));
            }
          },
        ),
      ),
    );
  }

  getLocations(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<Widget> items = [];
    if (snapshot.data != null) {
      for (DocumentSnapshot doc in snapshot.data.documents) {
        if (doc.data.containsKey('name') && doc.data['name'] is List) {
          for (String n in doc.data['name']) {
            items.add(new Container(
                child: new ListTile(title: new Text(n)),
                decoration: new BoxDecoration(
                    border: new Border(
                        bottom: new BorderSide(color: Colors.black26)))));
          }
        }
      }
    }
    return items;
  }
}
