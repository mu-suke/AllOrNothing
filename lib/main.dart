import 'package:flutter/material.dart';
import 'mySliderClass.dart';
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


class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<MySlider> _sliderList = [
    MySlider(title: 'hogehoge', value: 40),
  ];
  @override
  Widget build(BuildContext context) {
    if ( _sliderList.isNotEmpty ) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("text"),
              ListView.builder(
                itemCount: _sliderList.length,
                itemBuilder: (BuildContext context, int index){
                  return Column(
                    children: <Widget>[
                      Text(index.toString()),
                      // Text(_sliderList[index].title),
                      // Text(_sliderList[index].value.toString()),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addSlider(context).then((onValue){
              setState(() {
                _sliderList.add(onValue);
              });
            });
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      );
    }
    else {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Slider list is empty."),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addSlider(context).then((onValue){
              setState(() {
                _sliderList.add(onValue);
              });
            });
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      );
    }
  }

  Future<MySlider> _addSlider(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    double _value = 0.0;
    double _startValue = 0.0;
    double _endValue = 0.0;

    void _changeSlider(double e) => setState(() { _value = e; });
    void _startSlider(double e) => setState(() { _startValue = e; });
    void _endSlider(double e) => setState(() { _endValue = e; });
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
              Container(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    children: <Widget>[
                      Center(child:Text("現在の値：$_value")),
                      Center(child:Text("開始時の値：$_startValue")),
                      Center(child:Text("終了時の値：$_endValue")),
                      new Slider(
                        label: '$_value',
                        min: 0,
                        max: 100,
                        value: _value,
                        activeColor: Colors.orange,
                        inactiveColor: Colors.blueAccent,
                        divisions: 100,
                        onChanged: _changeSlider,
                        onChangeStart: _startSlider,
                        onChangeEnd: _endSlider,
                      )
                    ],
                  )
              ),
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
                  value: _value.toInt(),
                );
                Navigator.of(context).pop(_newSlider);
              },
            ),
          ],
        );
      },
    );
  }
}


