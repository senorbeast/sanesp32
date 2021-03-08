import 'package:flutter/material.dart';

class BlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: Center(
        // child: Container(
        child: Text(
          "THIS IS Ble PAGE",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
