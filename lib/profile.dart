import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'constants.dart';
import 'header.dart';
import 'menu.dart';

class Profile extends StatelessWidget {
  static String routeName = 'profileInfo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: emptyAppBar(),
        bottomNavigationBar: BottomNavBar(currentIndex: 2),
        body: SafeArea(
            child: ListView(
          children: [Header(text: 'Мой профиль'), Account(), MyMessages()],
        )));
  }
}

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: FlatButton(
            onPressed: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.person, color: Constants.accent),
                      Text('Аккаунт', style: Constants().subheader),
                    ],
                  ),
                ),
                Icon(CupertinoIcons.forward, color: Constants.black)
              ],
            )));
  }
}

class MyMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: FlatButton(
            onPressed: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(children: [
                  Icon(CupertinoIcons.doc_text_search, color: Constants.accent),
                  Text('Мои заявки', style: Constants().subheader),
                ])),
                Icon(CupertinoIcons.forward, color: Constants.black)
              ],
            )));
  }
}
