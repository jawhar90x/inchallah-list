import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Login.dart';

class splach extends StatefulWidget {
  const splach({Key? key}) : super(key: key);

  @override
  State<splach> createState() => _splachState();
}

class _splachState extends State<splach> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => login())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0BFFE3),
            Color(0xFF5910CE),
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(70.0),
              child: Image.asset(
                'assets/image/01.png',
                height: 450,
                width: 450,
              )),
          Padding(
            padding: const EdgeInsets.all(8.10),
            child: Text(
              'Welcome In Inchallah List',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          CircularProgressIndicator(),
        ],
      ),
    ));
  }
}
