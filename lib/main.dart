import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nw_station/pages/DevicesListPage.dart';
import 'package:nw_station/pages/LocationListPage.dart';
import 'package:nw_station/pages/MetersListPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
// import 'package:firebase_ui/l10n/localization.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Negawatt Station',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Negawatt Station'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<FirebaseUser> _listener;

  FirebaseUser _currentUser;

  PageController _pageController;
  int _selectedPage = 0;
  int _counter = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    _listener.cancel();
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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
   if (_currentUser == null) {
      return new SignInScreen(
        title: "Demo",
        header: new Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Text("Demo"),
          ),
        ),
        showBar: true,
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
        avoidBottomInset: true,
        color: Color(0xFF363636),
        providers: [
          ProvidersTypes.google,
          //ProvidersTypes.facebook,
          //ProvidersTypes.twitter,
          ProvidersTypes.email
        ],
        twitterConsumerKey: "",
        twitterConsumerSecret: "",
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: new PageView(
          children: [
            new LocationListPage(),
            new MetersListPage(),
            new DevicesListPage(),
          ],
          onPageChanged: _onPageBarTapped,
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
          ],
          currentIndex: _selectedPage,
          selectedItemColor: Colors.amber[800],
          onTap: _onPageBarTapped,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
  }

void _checkCurrentUser() async {
    _currentUser = await _auth.currentUser();
    _currentUser?.getIdToken(refresh: true);

    _listener = _auth.onAuthStateChanged.listen((FirebaseUser user) {
      setState(() {
        _currentUser = user;
      });
    });
  }  
}
