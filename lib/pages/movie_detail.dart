import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie.dart';
import 'package:flutter_movie/model/person.dart';
import 'package:http/http.dart' as http;

class MovieDetail extends StatefulWidget {
  final String id;

  MovieDetail(this.id);

  @override
  State<StatefulWidget> createState() => DetailState();
}

class DetailState extends State<MovieDetail> {
  MovieInfo movieInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
      ),
      body: _isShowProgress(),
    );
  }

  String _getTitle() {
    if (movieInfo == null) {
      return "详情";
    }
    return movieInfo.title;
  }

  Widget _isShowProgress() {
    if (movieInfo != null) {
      return Container(
        child: _itemBuild(),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  loadData() async {
    String url = "https://api.douban.com/v2/movie/subject/${widget.id}";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        movieInfo = MovieInfo.fromJson(json.decode(response.body));
      });
    } else {
      print("请求失败: ${response.statusCode}");
    }
  }

  Widget _itemBuild() {
    return ListView(
      padding: EdgeInsets.all(5.0),
      children: <Widget>[
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Text(
                movieInfo.original_title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 5,),
            Text(
              "(${movieInfo.year})",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(
              movieInfo.images.small,
              fit: BoxFit.fill,
              height: 200,
              alignment: Alignment.center,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "导演：",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  Text(
                    getPersonStr(movieInfo.directors),
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "演员：",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  Text(
                    getPersonStr(movieInfo.casts),
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "类型：",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            Expanded(
              child: Text(
                getStr(movieInfo.genres),
                style: TextStyle(fontSize: 15, color: Colors.blue),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "演员: ",
          style: TextStyle(fontSize: 16),
        ),
        Container(
          height: 180,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieInfo.directors.length + movieInfo.casts.length,
              itemBuilder: (BuildContext context, int position) {
                Person p;
                var prompt;
                if (position < movieInfo.directors.length) {
                  prompt = "导演";
                  p = movieInfo.directors[position];
                } else {
                  prompt = "演员";
                  p = movieInfo.casts[position - movieInfo.directors.length];
                }

                return _itemImages(p, prompt);
              }),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "剧情描述: ",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 5,
        ),
        Text(movieInfo.summary),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget _itemImages(Person person, String prompt) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.network(
            person.avatars.small,
            fit: BoxFit.fill,
            height: 130,
            alignment: Alignment.center,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            person.name,
            style: TextStyle(fontSize: 12),
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            prompt,
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  String getPersonStr(List<Person> data) {
    var arr = "";
    for (Person person in data) {
      if (arr != "") {
        arr += " / ";
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
