import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inchallah4/services/taskApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<Task>? myTasks = [];

  @override
  void initState() {
    super.initState();
    TaskApi().getAllTask().then((value) {
      setState(() {
        myTasks = value;
      });
    });
  }

  getAllTask() async {
    final prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');
    var url = Uri.parse('https://api-nodejs-todolist.herokuapp.com/task');
    var reponse = await http.get(
      url,
      headers: {
        "content-Type": "application/json",
        "Authorization": 'Bearer ${token}',
      },
    );
    print('Reponse status :  ${reponse.statusCode}');

    //print('Reponse bodd : ${reponse.body}');
    var bodReponse = jsonDecode((reponse.body));
    var arrayOftask = bodReponse['data'];

    for (var taskk in arrayOftask) {
      print(taskk);
    }
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'HOME',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                Text(
                  'Task : ${args['task']}',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 500,
                  /* child: IconButton(
                    alignment: Alignment.bottomRight,
                    icon: const Icon(
                      Icons.add,
                      size: 90,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      print("Pressed");

                      Navigator.pushNamed(context, '/add', arguments: {});
                    },
                  ),*/
                ),
                SizedBox(
                  width: 220,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/add', arguments: {});
                    },
                    child: Text(
                      'Add Task',
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/login', arguments: {});
                      getAllTask();
                    },
                    child: Text('LogOuddt')),
              ],
            ),
          ),
        ));
  }
}
