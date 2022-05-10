import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class TaskApi {
  List<Task>? addTask() {}

  Future<List<Task>?> getAllTask() async {
    List<Task> allTask = [];
    var url = Uri.parse('https://api-nodejs-todolist.herokuapp.com/task');

    final prefs = await SharedPreferences
        .getInstance(); // base de donne eli fi tel 5abina fiha tel
    final String? token = prefs.getString('token');

    var reponse = await http.get(
      url,
      headers: {
        "content-Type": "application/json",
        "Authorization": 'Bearer ${token}',
      },
    );
    print('Reponse status :  ${reponse.statusCode}');

    print('Reponse bodd : ${reponse.body}');

    if (reponse.statusCode == 200) {
      var bodReponse = jsonDecode((reponse.body));
      var arrayOftask = bodReponse['data'];

      for (var taskJson in arrayOftask) {
        //jebna mi  tableau Json wi n7otou fi List
        Task newTask = Task.fromJson(taskJson);
        allTask.add(newTask);
        //  print(taskJson);
      }
    } else {
      //TODO show error
    }
  }

  getData() async {
    List<Task>? myList =addTask();
    List<Task>? myList2 =await getAllTask();// cmt

    getAllTask().then((value) {// kif ccmt 2 5ater await sa3at ta9ef  donc netsta3mlou then
      List<Task>? myList2 =value;

    });
  }
}

