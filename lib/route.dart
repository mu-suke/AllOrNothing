import 'package:all_or_nothing_slider/pages/message/message_room.dart';
import 'package:all_or_nothing_slider/pages/message/message_route.dart';
import 'package:all_or_nothing_slider/pages/todo/todo_display.dart';
import 'package:flutter/material.dart';



class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  int _selectedIndex = 0;
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];

  static const _footerItems = [
    {
      'icon': Icons.check_box,
      'name': 'TODO',
    },
    {
      'icon': Icons.message,
      'name': 'メッセージ' ,
    }
  ];

  var _routes = [
    TodoDisplay(),
    MessageRoute()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bottomNavigationBarItems.add(_updateActiveState(0));
    for (var i = 1; i < _footerItems.length; i++) {
      _bottomNavigationBarItems.add(_updateDeactiveState(i));
    }
  }

  BottomNavigationBarItem _updateActiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerItems[index]['icon'],
          color: Colors.black87,
        ),
        title: Text(
          _footerItems[index]['name'],
          style: TextStyle(
            color: Colors.black87,
          ),
        )
    );
  }

  BottomNavigationBarItem _updateDeactiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
            _footerItems[index]['icon'],
            color: Colors.black26
        ),
        title: Text(
          _footerItems[index]['name'],
          style: TextStyle(
              color: Colors.black26
          ),
        )
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavigationBarItems[_selectedIndex] = _updateDeactiveState(_selectedIndex);
      _bottomNavigationBarItems[index] = _updateActiveState(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _routes.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}