import 'package:flutter/material.dart';

class MessageDisplay extends StatefulWidget {
  @override
  _MessageDisplayState createState() => _MessageDisplayState();
}

class _MessageDisplayState extends State<MessageDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("hogehoge"),
      ),
    );
  }
}
