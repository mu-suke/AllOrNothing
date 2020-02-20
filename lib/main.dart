import 'package:all_or_nothing_slider/blocs/slider_bloc.dart';
import 'package:all_or_nothing_slider/blocs/slider_provider.dart';
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
      home: SliderBlocProvider(
        child: MyHome(),
      )
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = SliderBlocProvider.of(context).bloc;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("test"),
            _text(bloc),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addSlider(context, bloc);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

Future<void> _addSlider(BuildContext context, SliderBloc bloc) {
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
              bloc.slider.add(_newSlider);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}


Widget _addSlider_(SliderBloc bloc) {
  TextEditingController _textController = TextEditingController();

  return StreamBuilder<bool>(
    stream: bloc.onToggle,
    builder: (context, snapshot) {
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
              bloc.start.add(_newSlider);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

Widget _text(SliderBloc bloc) {
  return StreamBuilder<MySlider>(
    stream: bloc.onAdd,
    builder: (context, snapshot) {
      return Column(
        children: <Widget>[
          Text(snapshot.hasData ? snapshot.data.title : ''),
          Text(snapshot.hasData ? snapshot.data.value.toString() : ''),
        ],
      );
    },
  );
}