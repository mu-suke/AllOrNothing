import 'package:all_or_nothing_slider/components/constText.dart';
import 'package:all_or_nothing_slider/mySliderClass.dart';
import 'package:flutter/material.dart';
import 'mySliderClass.dart';

class AddSliderPage extends StatefulWidget {
  @override
  _AddSliderPageState createState() => _AddSliderPageState();
}

class _AddSliderPageState extends State<AddSliderPage> {
  final MySlider _newSlider = MySlider.newSlider();
  TextEditingController _textController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(title: Text(ConstText.sliderCreateView)),
      body: Container(
          padding: const EdgeInsets.all(50.0),
          child: Column(
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
                ),
              ),
              RaisedButton.icon(
                  onPressed: () {
                    _newSlider.title = _textController.toString();
                    _newSlider.value = _value.toInt();
                    Navigator.of(context).pop(_newSlider);
                  },
                  icon: Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                  ),
                  label: Text("決定")
              )
            ],
          ),
      ),
    );
  }
}
