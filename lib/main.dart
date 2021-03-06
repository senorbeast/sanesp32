import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sanesp32/pages/blePg.dart';
import 'package:sanesp32/pages/joystickPg.dart';
import 'package:sanesp32/pages/settingPg.dart';

void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  final _pageOptions = [
    MainPage(),
    JSPage(),
    SettingPage()
  ]; // listing of all 3 pages index wise
  final bgcolor = [
    Colors.blueGrey[200],
    Colors.blueGrey[200],
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
