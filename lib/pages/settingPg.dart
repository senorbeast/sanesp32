import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            SizedBox(
              height: 100,
            ),
            ListTile(
                title: Text(
              'Sanitizing Robot',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 36,
                  fontWeight: FontWeight.w700),
            )),
            ListTile(
              title: Text(
                'Tab 1 :Connect to ESP32 with Bluetooth',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                'Discover Bluetooth Device and connect',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            ListTile(
              title: Text(
                'Tab 2 : Control Sanitizing Robot',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              subtitle: Column(
                children: [
                  Text(
                    '    - Joystick 1: With Up, Left, Right, Down you can control the Sanitizing Arm ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '    - Joystick 2: You can control the motion Sanitizing Car',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    'Made by EA-16',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            )
          ])),
    );
  }
}
