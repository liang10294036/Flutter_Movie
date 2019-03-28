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

class _NavigationTab extends State<HomePage> {
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
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        //设置标题居中
        elevation: 10,
        //设置标题栏下面阴影的高度
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.flag),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      resizeToAvoidBottomPadding: false,
      drawer: new Drawer(
        //侧边栏
        child: new Image.network(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1553748875788&di=f0d423c08a65bd976994fc1880483b14&imgtype=0&src=http%3A%2F%2Fwww.kedo.gov.cn%2Fupload%2Fresources%2Fimage%2F2018%2F03%2F25%2F182034.jpg",
          fit: BoxFit.fill,
        ),
      ),
      body: _pages[_currentItem]["fun"],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.hot_tub), title: Text(_pages[0]["name"])),
          BottomNavigationBarItem(
              icon: Icon(Icons.border_top), title: Text(_pages[1]["name"])),
        ],
//        type: BottomNavigationBarType.fixed,
        iconSize: 23,
        fixedColor: Colors.blue,
        currentIndex: _currentItem,
        onTap: (index) {
          setState(() {
            _currentItem = index;
          });
        },
      ),
    );
  }
}
