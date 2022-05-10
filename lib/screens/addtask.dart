import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class addtask extends StatefulWidget {
  const addtask({Key? key}) : super(key: key);

  @override
  State<addtask> createState() => _addtaskState();
}

class _addtaskState extends State<addtask> {
  List<String> task = [];
  late String temp;
  TextEditingController taskcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add TASK',
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
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 350,
                      height: 95,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(35, 35, 1, 10),
                        child: TextField(
                          onChanged: (str) {
                            temp = str;
                          },
                          controller: taskcontroller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: const EdgeInsets.all(8.0),
                              labelText: 'Add Task ',
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: ListView(
                        shrinkWrap: true,
                        children: task.map((e) => Text(e)).toList(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();

                        final String? token = prefs.getString('token');
                        var url = Uri.parse(
                            'https://api-nodejs-todolist.herokuapp.com/task');
                        var myBody = {
                          "description": taskcontroller.text,
                        };
                        var reponse = await http.post(
                          url,
                          body: jsonEncode(myBody),
                          headers: {
                            "content-Type": "application/json",
                            "Authorization": 'Bearer ${token}',
                          },
                        );

                        print('Reponse status :  ${reponse.statusCode}');

                        print('Reponse bodd : ${reponse.body}');

                        if (reponse.statusCode == 201) {
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Erreur ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER);
                        }
                      },
                      child: Text(
                        'Valider',
                      ),
                    ),

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
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
