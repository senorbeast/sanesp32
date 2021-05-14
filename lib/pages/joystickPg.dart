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
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: Text('Controller Page'),
        backgroundColor: Colors.deepPurpleAccent,
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
            // Positioned(
            //     bottom: 50,
            //     right: 10,
            //     child: Row(
            //       children: [
            //         ElevatedButton.icon(
            //           onPressed: () {},
            //           icon: Icon(Icons.fiber_manual_record),
            //           label: Text("Record"),
            //           style: ElevatedButton.styleFrom(primary: Colors.red),
            //         ),
            //         ElevatedButton.icon(
            //           onPressed: () {},
            //           icon: Icon(Icons.block),
            //           label: Text("Stop Record"),
            //           style: ElevatedButton.styleFrom(primary: Colors.grey),
            //         ),
            //       ],
            //     )),
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
                          PadButtonItem(
                              index: 0,
                              buttonText: 'Right',
                              backgroundColor: Colors.white54),
                          PadButtonItem(
                              index: 1,
                              buttonText: 'Down',
                              backgroundColor: Colors.white54),
                          PadButtonItem(
                              index: 2,
                              buttonText: 'Left',
                              backgroundColor: Colors.white54),
                          PadButtonItem(
                              index: 3,
                              buttonText: 'Up',
                              backgroundColor: Colors.white54)
                        ],
                      ),
                      JoystickView(
                        backgroundColor: Colors.black26,
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
