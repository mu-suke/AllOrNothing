import 'package:all_or_nothing_slider/data/const_text.dart';
import 'package:all_or_nothing_slider/pages/message/rooms.dart';
import 'package:flutter/material.dart';


class MessageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ConstText.messagePageTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          for(int i = 0; i < 15; i++)
            Rooms(icon: Icons.people_outline, username: 'mu-suke', message: 'test dayo',)
        ],
      ),
    );
  }
}
