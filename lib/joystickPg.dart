import 'package:control_pad/models/pad_button_item.dart';
import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';

class JSPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: AppBar(
        title: Text('Controller Page'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.black,
      ),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              PadButtonsView(
                size: 150,
                buttons: [
                  PadButtonItem(index: 0, buttonText: 'S'),
                  PadButtonItem(index: 1, buttonText: 'A'),
                  PadButtonItem(index: 2, buttonText: 'N'),
                  PadButtonItem(index: 3, buttonText: 'I')
                ],
              ),
              JoystickView(
                backgroundColor: Colors.grey,
                innerCircleColor: Colors.black38,
                size: 150,
                showArrows: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
