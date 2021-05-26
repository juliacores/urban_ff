import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../constants.dart';
import 'form.dart';
import '../modules/elements/header.dart';
import '../modules/menu.dart';

class Home extends StatelessWidget {
  static String routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: emptyAppBar(),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
      body: SafeArea(
          child: ListView(
            children: [
            Header(text:'Urban Feedback'),
            Image.asset('assets/banner.png'),
            Heading(),
            Description(),
            Message()
              ],
    )
    )
    )
    ;
  }
}

class Heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:10,left: 20,right: 20,bottom: 10),
      child: Text(
        'Поможем Петербургу стать комфортным',
      style: Constants().header)
    );
  }
}

class Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: Text(
        '''Здесь вы можете оставить отзыв о проблеме в городской инфраструктуре СПб, а также посмотреть аналитику проблем города.

Мы находимся в процессе сбора данных, а затем займемся тем, чтобы ваши проблемы были решены властями.

Ваше обращение очень важно для того, чтобы наш город стал комфортным для всех!
''',
style: Constants().maintext
      ),
    );
  }
}

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Constants.accent),
            margin: EdgeInsets.only(left: 40, right: 40, top: 10),
            //padding: EdgeInsets.all(6),
      child: FlatButton(
        child: Text(
          'Сообщить о проблеме',
          style: Constants().buttontext,
        ),
        onPressed:(){
          Navigator.of(context).pushNamed(Forma.routeName);
        }
        ,),
    );
  }
}