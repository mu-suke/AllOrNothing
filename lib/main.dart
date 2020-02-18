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
            MySliderComponent(),
            for (int i = 0; i < _sliderList.length;i++)
              Text(
                "title: ${_sliderList[i].title} \n value: ${_sliderList[i].value}",
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addSlider(context).then((onValue){
            if(onValue != null) {
              _sliderList.add(onValue);
              setState(() {});
            }

          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


