import 'package:control_pad/models/pad_button_item.dart';
import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';

class JSPage extends StatefulWidget {
  @override
  _JSPageState createState() => _JSPageState();
}

class _JSPageState extends State<JSPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: AppBar(
        title: Text('Controller Page'),
        backgroundColor: Colors.blueGrey,
        // foregroundColor: Colors.black,
      ),
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.refresh_outlined),
                label: Text("Reset"),
                style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      PadButtonsView(
                        size: 150,
                        buttons: [
                          PadButtonItem(index: 0, buttonText: 'Right'),
                          PadButtonItem(index: 1, buttonText: 'Down'),
                          PadButtonItem(index: 2, buttonText: 'Left'),
                          PadButtonItem(index: 3, buttonText: 'Up')
                        ],
                      ),
                      JoystickView(
                        backgroundColor: Colors.grey,
                        innerCircleColor: Colors.black38,
                        size: 150,
                        showArrows: false,
                        onDirectionChanged: (x, y) {
                          print("$x,$y");
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
