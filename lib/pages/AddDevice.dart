import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class AddDevicePage extends StatefulWidget {
  final String _userId;

  AddDevicePage(this._userId);

  @override
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  String _nickname;
  String _manufacturer;
  String _model;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Device"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Device Nickname'),
                  onSaved: (val) => setState(() => _nickname = val),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Device Name.';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Device Manufacturer'),
                  onSaved: (val) => setState(() => _manufacturer = val),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Device Name.';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Device Model'),
                  onSaved: (val) => setState(() => _model = val),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Device Name.';
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              _formKey.currentState.validate();
                              _formKey.currentState.save();

                              addDeviceDocument(widget._userId);
                              Navigator.pop(context);
                            },
                            child: Text('Save'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future addDeviceDocument(String userid) async {
    var record = {
      'nickname': _nickname,
      'model': _model,
      'manufacturer': _manufacturer
    };

    DocumentReference doc = await Firestore.instance
        .collection('users/${widget._userId}/devices')
        .add(record);
  }
}
