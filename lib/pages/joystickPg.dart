import 'dart:convert';
import 'dart:typed_data';

import 'package:control_pad/models/gestures.dart';
import 'package:control_pad/models/pad_button_item.dart';
import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class JSPage extends StatefulWidget {
  final BluetoothDevice server;

  const JSPage({Key key, this.server}) : super(key: key);

  @override
  _JSPageState createState() => _JSPageState();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _JSPageState extends State<JSPage> {
  static final clientID = 0;
  BluetoothConnection connection;

  List<_Message> messages = <_Message>[];
  String _messageBuffer = '';

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection.input.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  Widget build(BuildContext context) {
    Future padBUttonPressedCallback(int buttonIndex, Gestures gesture) async {
      // ignore: unnecessary_brace_in_string_interps
      String data = "buttonIndex : ${buttonIndex}";
      print(data);
      _sendMessage(data);
    }

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
                        padButtonPressedCallback: padBUttonPressedCallback,
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
                          _sendMessage("$x,$y");
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

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        connection.output.add(utf8.encode(text + "\r\n"));
        await connection.output.allSent;

        setState(() {
          messages.add(_Message(clientID, text));
        });

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}
