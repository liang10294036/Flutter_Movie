import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie/model/list_movie.dart';
import 'package:flutter_movie/model/movie.dart';
import 'package:flutter_movie/model/person.dart';
import 'package:http/http.dart' as http;

class TopList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TopPage();
  }
}

class TopPage extends State<TopList> {
  ListMovie listMovie;
  List<MovieInfo> movies = [];
  String appTitle = "豆瓣电影";
  String appFirstMovie = "";

  ScrollController _scrollController = ScrollController();

  int currentPage = 0;
  int addPageIndex = 1;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: false,
        //设置标题居中
        elevation: 10,
        //设置标题栏下面阴影的高度
      ),
      body: Center(
        child: _isShowProgress(),
      ),
    );
  }

  Widget _isShowProgress() {
//    if (movies.length > 0) {
    return RefreshIndicator(
        //下拉刷新
        onRefresh: () => loadData(0),
        child: GridView.count(
            mainAxisSpacing: 10.0,
            crossAxisCount: 2,
            padding: const EdgeInsets.all(8.0),
            //宽高比
            childAspectRatio: 1 / 1.2,
            children: List.generate(10, (index) {
              return Card(
                
                child: _listItemBuild(index),
              );
            })));
//    } else {
//      return CircularProgressIndicator();
//    }
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
            "http://api.douban.com/v2/movie/top250?apikey=0b2bdeda43b5688921839c8ecb20399b&start=$start&count=10";
        http.Response response = await http.get(url);
        if (response.statusCode == 200) {
          setState(() {
            listMovie = ListMovie.fromJson(json.decode(response.body));
            appTitle = listMovie.title;
            print("listMovie: ${listMovie.title}");
            if (page == 0) {
              movies = listMovie.subjects;
              appFirstMovie = movies[0].images.large;
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
    MovieInfo movie = movies[position];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 15, color: Colors.black87),
            softWrap: false,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Image.network(
          movie.images.small,
          fit: BoxFit.fitWidth,
          alignment: Alignment.center,
          height: 150,
        ),
        SizedBox(
          height: 5.0,
        ),
        Expanded(
          child: Text(
            getStr(movie.genres)+ "   ${movie.rating.average}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
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
}
