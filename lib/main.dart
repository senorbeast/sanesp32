import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sanesp32/pages/blePg.dart';
import 'package:sanesp32/pages/bleOFF.dart';
import 'package:sanesp32/pages/joystickPg.dart';
import 'package:sanesp32/pages/settingPg.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() => runApp(MaterialApp(home: FlutterBlueApp()));

class FlutterBlueApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.lightBlue,
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return BottomNavBar();
            }
            return BluetoothOffScreen(state: state);
          }),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  final _pageOptions = [
    BlePage(),
    JSPage(),
    SettingPage()
  ]; // listing of all 3 pages index wise
  final bgcolor = [
    Colors.blue[400],
    Colors.orange[300],
    Colors.blueGrey[200]
  ]; // changing color as per active index value
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.list, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: bgcolor[_page],
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: _pageOptions[_page]);
  }
}
