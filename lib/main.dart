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
      home: MyHomePage(title: 'All or Nothing Slider'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MySlider> _sliderList = [];

  Future<MySlider> _addSlider(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    double _value = 0.0;
    double _startValue = 0.0;
    double _endValue = 0.0;
    int displayValue = 0;
    void _changeSlider(double e) => setState(() {
      _value = e;
      displayValue = e.toInt();
    });
    void _startSlider(double e) => setState(() { _startValue = e; });
    void _endSlider(double e) => setState(() { _endValue = e; });
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("新規スライダーを作成"),
          content: Column(
            children: <Widget>[
              TextField(
                controller: _textController,
              ),
              Slider(
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
                  value: displayValue,
                );
                Navigator.of(context).pop(_newSlider);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'All or Nothing?'
            ),
            for (int i = 0; i < _sliderList.length;i++)
              Text(
                "title: ${_sliderList[i].title}",
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addSlider(context).then((onValue){
            SnackBar mySnackBar = SnackBar(content: Text("Hello $onValue"));
            Scaffold.of(context).showSnackBar(mySnackBar);
            setState(() {
//              _sliderList.add(onValue);
            });
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


