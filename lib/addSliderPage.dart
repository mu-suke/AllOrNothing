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

  void _changeSlider(double e) => setState(() {
        _value = e;
      });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text(ConstText.sliderCreateView)),
      body: Form(
        key: _formKey,
        child: Container(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'テキストを入力してください。';
                    }
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    children: <Widget>[
                      Center(child: Text("現在の値：${_value.toInt()}")),
                      new Slider(
                        label: '${_value.toInt()}',
                        min: 0,
                        max: 100,
                        value: _value,
                        activeColor: Colors.orange,
                        inactiveColor: Colors.blueAccent,
                        divisions: 20,
                        onChanged: _changeSlider,
                      )
                    ],
                  ),
                ),
                RaisedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _newSlider.title = _textController.text.toString();
                        _newSlider.value = _value.toInt();
                        Navigator.of(context).pop(_newSlider);
                      }
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
      ),
    );
  }
}
