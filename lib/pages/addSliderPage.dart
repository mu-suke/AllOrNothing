import 'package:all_or_nothing_slider/components/prioritySlider.dart';
import 'package:all_or_nothing_slider/data/constText.dart';
import 'package:all_or_nothing_slider/data/mySliderClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/mySliderClass.dart';

class AddSliderPage extends StatefulWidget {
  @override
  _AddSliderPageState createState() => _AddSliderPageState();
}

class _AddSliderPageState extends State<AddSliderPage> {
  final MySlider _newSlider = MySlider.newSlider();
  String _title = '';
  double _value = 0;
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
                padding: EdgeInsets.all(50.0),
                child: PrioritySlider(
                  notifier: sliderChangeNotifier,
                  onSubmit: (int val) {
                    _value = val.toDouble();
                  },
                ),
              ),
              RaisedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _saveTodo(_title, _value, DateTime.now());
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
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _saveTodo(title, value, createdAt) {
  Firestore.instance.collection('users').add({
    'title': title,
    'value': value.toInt(),
    'createdAt': DateTime.now()
  });
}