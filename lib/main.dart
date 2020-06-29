import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nw_station/pages/AddDevice.dart';
import 'package:nw_station/pages/DevicesListPage.dart';
import 'package:nw_station/pages/LocationListPage.dart';
import 'package:nw_station/pages/MetersListPage.dart';
import 'package:nw_station/pages/TakePicturePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth/LoginButton.dart';
import 'auth/auth.dart';

//import 'package:firebase_ui/flutter_firebase_ui.dart';
//import 'package:firebase_ui/l10n/localization.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Negawatt Station',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Negawatt Station'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;
  String _username;
  String _userEmail;
  String _userId;

  int _selectedPage = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();

    authService.user.listen((FirebaseUser u) {
      setState(() {
        if (u == null) {
          _username = null;
          _userEmail = null;
          _userId = null;
        } else {
          _username = u.displayName;
          _userEmail = u.email;
          _userId = u.uid;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onPageBarTapped(int pageIndex) {
    setState(() {
      _selectedPage = pageIndex;
      _pageController.animateToPage(pageIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            _userEmail != null
                ? UserAccountsDrawerHeader(
                    accountName: Text(_userEmail),
                    accountEmail: Text(_username),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).platform == TargetPlatform.iOS
                              ? Colors.blue
                              : Colors.white,
                      child: Text(
                        _username.substring(0, 1),
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  )
                : Offstage(),
            new LoginButton(_userEmail != null),
          ],
        ),
      ),
      body: new PageView(
        children: [
          new LocationListPage(_userId),
          new MeterListPage(_userId),
          new DeviceListPage(_userId),
          new TakePicturePage(),
        ],
          // onPageChanged: _onPageBarTapped,
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.my_location),
            title: Text('Locations'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.power_input),
            title: Text('Meters'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            title: Text('Devices'),
          ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              title: Text('Camera'),
            ),
        ],
        currentIndex: _selectedPage,
        selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.black,
        onTap: _onPageBarTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedPage == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddDevicePage(_userId)));
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
