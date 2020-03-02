import 'package:flutter/material.dart';

import '../mySliderClass.dart';

class AddNewSlider extends StatefulWidget {
  @override
  _AddNewSliderState createState() => _AddNewSliderState();
}

class _AddNewSliderState extends State<AddNewSlider> {
  double _value = 0.0;
  double _startValue = 0.0;
  double _endValue = 0.0;

  void _changeSlider(double e) => setState(() {
        _value = e;
      });

  void _startSlider(double e) => setState(() {
        _startValue = e;
      });

  void _endSlider(double e) => setState(() {
        _endValue = e;
      });

  @override
  Widget build(BuildContext context) {
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
                Container(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      children: <Widget>[
                        Center(child: Text("現在の値：$_value")),
                        Center(child: Text("開始時の値：$_startValue")),
                        Center(child: Text("終了時の値：$_endValue")),
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
                    )),
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
}
