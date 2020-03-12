import 'package:all_or_nothing_slider/pages/addSliderPage.dart';
import 'package:all_or_nothing_slider/components/constText.dart';
import 'package:flutter/material.dart';
import 'components/mySliderClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ConstText.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Colors.white
          )
        )
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

Future getData(String collection, String documentId, String fieldName) async {
  DocumentSnapshot docSnapshot =
  await Firestore.instance.collection(collection).document(documentId).get();
  Map record = docSnapshot.data;
  return record[fieldName];
}
final snapshot =  getData('users', 'test_data', 'title');
class _MyHomeState extends State<MyHome> {

  List<MySlider> _sliderList = [
    MySlider(title: 'hogehoge', value: 40, createdAt: DateTime.now()),
    MySlider(title: getData('users', 'test_data', 'title').toString(), value: 77, createdAt: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    if (_sliderList.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(ConstText.appTitle),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: _sliderList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_sliderList[index].title),
                subtitle: Text('${_sliderList[index].value}'),
                onTap: () {
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text('Created at ${_sliderList[index].createdAt.toIso8601String()}'),
                  ));
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final MySlider _newSlider = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return AddSliderPage();
            }));
            if (_newSlider != null) {
              setState(() {
                _sliderList.add(_newSlider);
              });
            }
          },
          tooltip: 'Increment',
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(ConstText.appTitle),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Slider list is empty."),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final MySlider _newSlider = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return AddSliderPage();
            }));
            if (_newSlider != null) {
              setState(() {
                _sliderList.add(_newSlider);
              });
            }
          },
          tooltip: 'Increment',
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
  }
}