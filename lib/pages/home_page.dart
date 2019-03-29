import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/hot_list.dart';
import 'package:flutter_movie/pages/top_list.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NavigationTab();
  }
}

class _NavigationTab extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  var _pages;
  var _currentItem = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {"name": "热映", "fun": HotList()},
      {"name": "评分", "fun": TopList()}
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[_pages[0]["fun"], _pages[1]["fun"]],
        index: _currentItem,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.hot_tub), title: Text(_pages[0]["name"])),
          BottomNavigationBarItem(
              icon: Icon(Icons.border_top), title: Text(_pages[1]["name"])),
        ],
//        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        fixedColor: Colors.blue,
        currentIndex: _currentItem,
        onTap: (index) {
          if (_currentItem != index) {
            setState(() {
              _currentItem = index;
            });
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
