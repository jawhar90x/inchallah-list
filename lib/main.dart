import 'package:flutter/material.dart';
import 'package:inchallah4/screens/NewAcount.dart';
import 'package:inchallah4/screens/addtask.dart';
import 'package:inchallah4/screens/splach_screen.dart';

import 'screens/Login.dart';
import 'screens/home.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(
  //    SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const splach(),
      routes: {
        '/': (context) => splach(),
        '/login': (context) => login(),
        '/NewAcc': (context) => Newaccount(),
        '/home': (context) => home(),
        '/add': (context) => addtask(),
      },
    );
  }
}
