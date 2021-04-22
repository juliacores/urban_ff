import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'constants.dart';
import 'constants.dart';
import 'header.dart';
import 'menu.dart';

class Analytics extends StatelessWidget {
  static String routeName = 'getAnalytics';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: emptyAppBar(),
        bottomNavigationBar: BottomNavBar(currentIndex: 1),
        body: SafeArea(
            child: ListView(
          children: [Header(text: 'Анализ проблем'), Map(), Problems()],
        )));
  }
}

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.all(10),
        child: FlatButton(
            onPressed: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(children: [
                  Icon(CupertinoIcons.map, color: Constants.accent),
                  Text('Карта проблем', style: Constants().subheader),
                ])),
                Icon(CupertinoIcons.forward, color: Constants.black)
              ],
            )));
  }
}

class Problems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.all(10),
        child: FlatButton(
            onPressed: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(children: [
                  Icon(CupertinoIcons.chart_pie, color: Constants.accent),
                  Text('Список проблем', style: Constants().subheader),
                ])),
                Icon(CupertinoIcons.forward, color: Constants.black)
              ],
            )));
  }
}
