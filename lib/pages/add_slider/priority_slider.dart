import 'package:flutter/material.dart';

class PrioritySlider extends StatefulWidget {
  SliderValueCallback onSubmit;
  ValueNotifier<int> notifier;
  PrioritySlider({this.onSubmit, this.notifier}) {
    print("PrioritySlider build");
  }
  @override
  _PrioritySliderState createState() => _PrioritySliderState(notifier: notifier);
}

typedef void SliderValueCallback(int value);

class _PrioritySliderState extends State<PrioritySlider> {

  int _value;
  ValueNotifier<int> notifier;

  _PrioritySliderState({this.notifier}) {
    notifier.addListener(() {
      setState(() {
        this._value = notifier.value;
      });
    });
    _value = this.notifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(child: Text("現在の値：$_value")),
        Slider(
          label: '$_value',
          min: 0,
          max: 100,
          value: _value.toDouble(),
          activeColor: Colors.orange,
          inactiveColor: Colors.lightBlue,
          divisions: 20,
          onChanged: (_newValue) {
            setState(() {
              _value = _newValue.toInt();
              widget.onSubmit(_value);
            });
          },
        ),
      ],
    );
  }
}
