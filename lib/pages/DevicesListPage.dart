import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DeviceListPage extends StatefulWidget {
  String _userId;

  DeviceListPage(this._userId);

  @override
  _DeviceListPageState createState() => _DeviceListPageState();
}

class _DeviceListPageState extends State<DeviceListPage> {
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
              .collection('users/${widget._userId}/devices')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Center(child: new CircularProgressIndicator());
              default:
                return new ListView(children: getDevices(snapshot));
            }
          },
        ),
      ),
    );
  }

  getDevices(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<Widget> items = [];
    if (widget._userId != null) {
      for (DocumentSnapshot doc in snapshot.data.documents) {
        items.add(Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                  leading: Icon(Icons.power_input),
                  title: Text(doc.data['nickname']),
                  subtitle:
                  Text("${doc.data['manufacturer']} ${doc.data['model']}"))
            ])));
      }
    }

    return items;
  }
}