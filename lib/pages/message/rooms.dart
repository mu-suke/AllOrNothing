import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'message_room.dart';

class Rooms extends StatelessWidget {
  IconData icon;
  String username;
  String message;

  Rooms({IconData icon, String username, String message}) {
    this.icon = icon;
    this.username = username;
    this.message = message;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(this.icon),
            backgroundColor: Colors.yellow,
          ),
          title: Text(this.username),
          subtitle: Text(this.message),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessageRoom(
                  username: this.username,
                )
              )
            )
          },
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          color: Colors.blue,
          icon: Icons.flash_off,
          onTap: () {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('COMING SOON...'),
              duration: Duration(seconds: 1),
            ));
          },
        ),
        IconSlideAction(
          color: Colors.indigo,
          icon: Icons.volume_off,
          onTap: () {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('COMING SOON...'),
              duration: Duration(seconds: 1),
            ));
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          color: Colors.black45,
          iconWidget: Text(
            'delete',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('COMING SOON...'),
              duration: Duration(seconds: 1),
            ));
          },
        )
      ],
    );
  }
}
