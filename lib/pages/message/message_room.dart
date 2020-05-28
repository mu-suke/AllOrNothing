import 'package:all_or_nothing_slider/data/const_text.dart';
import 'package:flutter/material.dart';

class MessageRoom extends StatelessWidget {
  String username;
  MessageRoom({String username}) {
    this.username = username;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(this.username),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: messaggeRoom(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('COMING SOON...'),
                  duration: Duration(seconds: 1),
                ));
              },
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('COMING SOON...'),
                  duration: Duration(seconds: 1),
                ));
              },
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('COMING SOON...'),
                  duration: Duration(seconds: 1),
                ));
              },
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'input area'
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('COMING SOON...'),
                  duration: Duration(seconds: 1),
                ));
              },
            )
          ],
        ),
      ),
    );
  }
  Widget messaggeRoom() {
    return Text('メッセージ予定地');
  }
}
