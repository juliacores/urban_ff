import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/Screens/analytics.dart';
import 'package:quiz/Screens/home.dart';
import 'package:quiz/Screens/problems_screen.dart';
import 'package:quiz/Screens/profile.dart';
import 'Screens/problems-map.dart';
import 'constants.dart';
import 'constants.dart';
import 'Screens/form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban Feedback',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Constants.accent,
        brightness: Brightness.light,
        accentColor: Constants.accent,
        scaffoldBackgroundColor: Colors.white
        //primarySwatch: Colors.teal,

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: Home(),
      initialRoute: '/',
      routes: {
        '/':(context)=> Home(),
        Forma.routeName:(ctx)=>Forma(),
        Profile.routeName:(ctx)=>Profile(),
        Analytics.routeName:(ctx)=>Analytics(),
        ProblemsListScreen.routeName:(ctx)=>ProblemsListScreen(),
        ProblemsMap.routeName:(ctx)=>ProblemsMap(),
      },
    );
  }
}
