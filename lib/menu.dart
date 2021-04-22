import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/analytics.dart';
import 'package:quiz/home.dart';
import 'package:quiz/profile.dart';

import 'constants.dart';


class BottomNavBar extends StatefulWidget {
  final int currentIndex;

  BottomNavBar({
    @required this.currentIndex,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // Copyright 2021 Roman Kores. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
  int lenght = 100;
  int curPos = 0;
  double screenWidth;
  String title = '';
  bool playing = false;
  bool unchecked = true;

  @override
  initState(){
    unchecked = true;
    super.initState();
  }

  onTabTapped(int index) {
    var routeName = '/';
    Widget screen;
    switch (index) {
      case 0:
        screen = Home();
        routeName = Home.routeName;
        break;
      case 1:
        screen = Analytics();
        routeName = Analytics.routeName;
        break;
      case 2:
        screen = Profile();
        routeName = Profile.routeName;
        break;
      default:
        break;
    }
    //Navigator.pushNamed(context, routeName);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => screen,
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;

    return Container(
        color: Constants.background,
        child:
        SafeArea(
            maintainBottomViewPadding: true,
            child: SizedBox(
              height: 46,
              width: double.infinity,
              //height: 100,
              child:
                  BottomNavigationBar(
                    onTap: onTabTapped,
                    currentIndex: widget.currentIndex,
                    elevation: 0,
                    backgroundColor: Constants.background,
                    selectedLabelStyle: Constants().menuaccent,
                    unselectedLabelStyle: Constants().menu,
                    iconSize: 20,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.house),
                        label:'Сообщение',
                        backgroundColor: Colors.white,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.chart_pie),
                        label: 'Анализ проблем',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.person),
                        label: 'Мой профиль',
                      ),
                    ],
                  ),
              ),
        )
            );
  }
}