import 'package:flutter/material.dart';

class NewSliderCreate extends StatefulWidget {
  @override
  _NewSliderCreateState createState() => _NewSliderCreateState();
}

class _NewSliderCreateState extends State<NewSliderCreate> {
  @override
  Widget build(BuildContext context) {
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
    return Container();
  }
}
