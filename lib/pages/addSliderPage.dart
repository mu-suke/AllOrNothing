import 'package:all_or_nothing_slider/components/constText.dart';
import 'package:all_or_nothing_slider/components/mySliderClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/mySliderClass.dart';

class AddSliderPage extends StatefulWidget {
  @override
  _AddSliderPageState createState() => _AddSliderPageState();
}

class _AddSliderPageState extends State<AddSliderPage> {
  final MySlider _newSlider = MySlider.newSlider();
  String _title = '';
  double _value = 0.0;
  ValueNotifier<int> sliderChangeNotifier;

  _AddSliderPageState() {
    sliderChangeNotifier = ValueNotifier<int>(0);
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
          title: Text(ConstText.sliderCreateView),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: () => Navigator.of(context).pop(),
          ),
      ),
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
                onChanged: (_formKey) {
                  _title = _formKey;
                },
              ),
              Container(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  children: <Widget>[
                    Center(child: Text("現在の値：${sliderChangeNotifier.value}")),
                    PrioritySlider(notifier: sliderChangeNotifier),
                  ],
                ),
              ),
              RaisedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _newSlider.title = _title;
                      _newSlider.value = sliderChangeNotifier.value;
                      _newSlider.createdAt = DateTime.now();
                      Firestore.instance.collection('users').add({
                        'title': _title,
                        'value': _value.toInt(),
                        'createdAt': DateTime.now()
                      });
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.lightBlue,
                  icon: Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                  ),
                  label: Text(
                    "決定",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class PrioritySlider extends StatefulWidget {
  ValueNotifier<int> notifier;
  PrioritySlider({this.notifier}) {
    print("PrioritySlider build");
  }
  @override
  _PrioritySliderState createState() => _PrioritySliderState(notifier: notifier);
}

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
    return Slider(
      label: '$_value',
      min: 0,
      max: 100,
      value: _value.toDouble(),
      activeColor: Colors.orange,
      inactiveColor: Colors.lightBlue,
      divisions: 20,
      onChanged: (_newValue) {
        setState(() {
          this._value = _newValue.toInt();
        });
      },
    );
  }
}
// TODO: setStateすることによってtitleテキストが初期化される
