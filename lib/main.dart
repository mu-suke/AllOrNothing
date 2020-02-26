import 'package:flutter/material.dart';
import 'mySliderClass.dart';
import 'package:all_or_nothing_slider/components/mySliderComponent.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home:  MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("test"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addSlider(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

Future<void> _addSlider(BuildContext context) {
  TextEditingController _textController = TextEditingController();
  return showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text("新規スライダーを作成"),
        content: Column(
          children: <Widget>[
            TextField(
              controller: _textController,
            ),
            MySliderComponent(),
          ],
        ),
        actions: <Widget>[
          // ボタン領域
          FlatButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              final MySlider _newSlider = MySlider(
                title: _textController.text.toString(),
                value: 100,
              );
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}