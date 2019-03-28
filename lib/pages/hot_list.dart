import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie.dart';
import 'package:flutter_movie/model/list_movie.dart';
import 'package:flutter_movie/model/person.dart';
import 'package:flutter_movie/model/rating.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class HotList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HotPage();
}

class HotPage extends State<HotList> {
  ScrollController _scrollController = ScrollController();

  int currentPage = 0;
  int addPageIndex = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData(0);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("滑动最底部");
        loadData(currentPage + 1);
      }
    });
  }

  ListMovie listMovie;
  List<MovieInfo> movies = [];
  String appTitle = "豆瓣电影";
  String appFirstMovie =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1553748875788&di=f0d423c08a65bd976994fc1880483b14&imgtype=0&src=http%3A%2F%2Fwww.kedo.gov.cn%2Fupload%2Fresources%2Fimage%2F2018%2F03%2F25%2F182034.jpg";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: false,
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
      body: Center(
        child: _isShowProgress(),
      ),
      resizeToAvoidBottomPadding: false,
      drawer: new Drawer(
        //侧边栏
        child: new Image.network(
          appFirstMovie,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _isShowProgress() {
    if (movies.length > 0) {
      return RefreshIndicator(
          //下拉刷新
          onRefresh: () => loadData(0),
          child: ListView.builder(
              itemCount: movies.length + addPageIndex,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int position) =>
                  _listItemBuild(position)));
    } else {
      return CircularProgressIndicator();
    }
  }

  loadData(int page) async {
    currentPage = page;
    print("isLoading: $isLoading");
    if (!isLoading) {
      int start = page * 10;
      if (listMovie == null || listMovie.total > start) {
        isLoading = true;
        addPageIndex = 1;
        String url =
            "https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&start=$start&count=10";
        http.Response response = await http.get(url);
        if (response.statusCode == 200) {
          setState(() {
            listMovie = ListMovie.fromJson(json.decode(response.body));
            appTitle = listMovie.title;
            print("listMovie: ${listMovie.title}");
            if (page == 0) {
              movies = listMovie.subjects;
              appFirstMovie = movies[0].images.medium;
            } else {
              movies.addAll(listMovie.subjects);
            }
          });
        } else {
          print("请求失败: ${response.statusCode}");
        }
        isLoading = false;
      } else {
        setState(() {
          addPageIndex = 0;
        });
      }
    }
  }

  Widget _listItemBuild(int position) {
    if (position < movies.length) {
      MovieInfo movie = movies[position];
      return GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("No.$position"),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Image.network(
                  movie.images.small,
                  height: 150,
                  width: 100,
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.play_circle_filled,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(
                              movie.title,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text("(${movie.year})"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: getStarsWidgets(movie.rating)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${getPersonStr(movie.directors)} / ${getStr(movie.genres)}",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(color: Colors.blue, fontSize: 13.0),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "演员： ${getPersonStr(movie.casts)}",
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            )
          ],
        ),
        onTap: () {
          print("${movie.title}");
        },
      );
    } else {
      return Container(
        alignment: Alignment.center,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("正在加载..."),
            SizedBox(
              width: 5,
            ),
            SizedBox(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
              height: 15,
              width: 15,
            )
          ],
        ),
      );
    }
  }

  String getPersonStr(List<Person> data) {
    var arr = "";
    for (Person person in data) {
      if (arr != "") {
        arr += "  ";
      }
      arr += person.name;
    }
    return arr;
  }

  String getStr(List<String> data) {
    var arr = "";
    for (String s in data) {
      if (arr != "") {
        arr += " • ";
      }
      arr += s;
    }
    return arr;
  }

  List<Widget> getStarsWidgets(Rating rating) {
    int sta = int.parse(rating.stars);
    double stars = sta / 10;
    List<Widget> widgets = [];
    for (int i = 0; i < 5; i++) {
      if (stars > i) {
        widgets.add(Icon(
          Icons.star,
          size: 16,
          color: Colors.yellow,
        ));
      } else {
        widgets.add(Icon(
          Icons.star,
          size: 16,
          color: Colors.grey,
        ));
      }
    }
    widgets.add(SizedBox(
      width: 5,
    ));
    widgets.add(Text(
      "${rating.average}",
      style: TextStyle(color: Colors.grey, fontSize: 13.0),
    ));
    return widgets;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}
