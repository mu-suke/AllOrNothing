import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoListStore with ChangeNotifier {
  
  void saveTodo(_title, _value) {
    Firestore.instance.collection('datas').add({
      'title': _title,
      'value': _value.toInt(),
      'createdAt': DateTime.now()
    });
    notifyListeners();
  }
}