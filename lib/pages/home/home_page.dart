import 'package:all_or_nothing_slider/data/const_text.dart';
import 'package:all_or_nothing_slider/pages/add_slider/add_slider_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart' as timeAgo;

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

Future getData(String collection, String documentId, String fieldName) async {
  DocumentSnapshot docSnapshot = await Firestore.instance
      .collection(collection)
      .document(documentId)
      .get();
  Map record = docSnapshot.data;
  return record[fieldName];
}

final snapshot = getData('users', 'test_data', 'title');

class _MyHomeState extends State<MyHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ConstText.appTitle),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return AddSliderPage();
          }));
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget createListView() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                  )
                ],
              ),
            );
          default:
            return ListView(
              children:
              snapshot.data.documents.map((DocumentSnapshot document) {
                return Container(
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Colors.black38))),
                  child: ListTile(
                    trailing: Visibility(
                      visible:
                      _isCreatedAtCheck(document['createdAt'].toDate()),
                      child: Icon(
                        Icons.fiber_new,
                        color: Colors.lightBlue,
                        size: 30,
                      ),
                    ),
                    title: Text(document['title']),
                    subtitle: Text(document['value'].toString()),
                    onTap: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Created at ${timeAgo.format(document['createdAt'].toDate()).toString()}'),
                        duration: Duration(seconds: 1),
                      ));
                    },
                    onLongPress: () {
                      _showDialog().then((value) {
                        if(value) {
                          _deleteTodo(document);
                        }
                      });
                    },
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }

  Future<bool> _showDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('確認'),
        content: Text('削除しますか？'),
        actions: <Widget>[
          SimpleDialogOption(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          SimpleDialogOption(
            child: Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
  }
}

bool _isCreatedAtCheck(DateTime createdAt) {
  const _oneWeek2Second = 7 * 24 * 60 * 60;
  final _createdAtSecond = createdAt.millisecondsSinceEpoch / 1000;
  final _clockSecond = DateTime.now().millisecondsSinceEpoch / 1000;
  final bool _isWithin1week = _clockSecond - _createdAtSecond < _oneWeek2Second;
  return _isWithin1week;
}

void _deleteTodo(DocumentSnapshot document) {
  Firestore.instance.collection('users').document(document.documentID).delete();
}

// TODO: サイズ調整
// TODO: 文字入力時bottom-overの修正
