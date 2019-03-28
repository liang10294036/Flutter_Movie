import 'package:flutter/material.dart';

class TopList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TopPage();
  }
}

class TopPage extends State<TopList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("第二个页面"),
    );
    ;
  }
}
