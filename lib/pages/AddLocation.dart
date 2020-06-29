import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class AddLocationPage extends StatefulWidget {
  final String _userId;

  AddLocationPage(this._userId);

  @override
  _AddLocationPageState createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  String _location;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Location"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Location'),
                  onSaved: (val) => setState(() => _location = val),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Location';
                    }
                    return value;
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

                              addLocationDocument(widget._userId);
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

  Future addLocationDocument(String userid) async {
    var record = {
      'location': _location,
    };

    DocumentReference doc = await Firestore.instance
        .collection('users/${widget._userId}/locations')
        .add(record);
  }
}
