import 'package:all_or_nothing_slider/pages/addSliderPage.dart';
import 'package:all_or_nothing_slider/components/constText.dart';
import 'package:all_or_nothing_slider/theme.dart';
import 'components/mySliderClass.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ConstText.appTitle,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ja', 'JP'),
      ],
      home: MyHome(),
    );
  }
}

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
            return Text('Loading...');
          default:
            return ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black38))),
                  child: new ListTile(
                    trailing: Visibility(
                      visible:
                          _isCreatedAtCheck(document['createdAt'].toDate()),
                      child: new Icon(
                        Icons.fiber_new,
                        color: Colors.lightBlue,
                        size: 30,
                      ),
                    ),
                    title: new Text(document['title']),
                    subtitle: new Text(document['value'].toString()),
                    onTap: () {
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text('Created at ${timeAgo.format(document['createdAt'].toDate()).toString()}'),
                        duration: Duration(seconds: 1),
                      ));
                    },
                    onLongPress: () {
                      _showDialog().then((value) {
                        if(value) {
                          Firestore.instance.collection('users').document(document.documentID).delete();
                          print("document deleted");
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
      builder: (BuildContext context) => new AlertDialog(
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

// TODO: フォントの変更
// TODO: サイズ調整
// TODO: 文字入力時bottom-overの修正
