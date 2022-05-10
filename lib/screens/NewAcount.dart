import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Newaccount extends StatefulWidget {
  const Newaccount({Key? key}) : super(key: key);

  @override
  State<Newaccount> createState() => _NewaccountState();
}

class _NewaccountState extends State<Newaccount> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Padding(
                padding: const EdgeInsets.all(30.10),
                child: Text(
                  'Registre',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(8.0),
                        labelText: 'Enter  E-mail',
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(8.0),
                        labelText: 'Name',
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(8.0),
                        labelText: 'password',
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(8.0),
                        labelText: 'Age',
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        nameController.text.isEmpty ||
                        ageController.text.isEmpty) {
                      //   print(emailController.text);
                      Fluttertoast.showToast(
                          msg: "Champs obligatoire",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER);
                    } else if (!EmailValidator.validate(emailController.text)) {
                      print(passwordController.text);
                      Fluttertoast.showToast(
                          msg: "Email non valid",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER);
                    } else if (passwordController.text.length < 8) {
                      Fluttertoast.showToast(
                          msg: "short password ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER);
                    } else {
                      //Navigator.pushNamed(context, '/login', arguments: {});
                      var url = Uri.parse(
                          'https://api-nodejs-todolist.herokuapp.com/user/register');
                      var myBody = {
                        "name": nameController.text,
                        "email": emailController.text,
                        "password": passwordController.text,
                        "age": ageController.text
                      };
                      var reponse = await http.post(url,
                          body: jsonEncode(myBody),
                          headers: {"content-Type": "application/json"});

                      print('Reponse status :  ${reponse.statusCode}');

                      print('Reponse bodd : ${reponse.body}');
                      if (reponse.statusCode == 201) {
                        var bodReponse =
                            jsonDecode((reponse.body)); // dicodage du token
                        print(bodReponse['token']);

                        final prefs = await SharedPreferences
                            .getInstance(); // for save token in base interne
                        prefs.setString('token',
                            bodReponse['token']); //ta5ou token men prefs
                        Navigator.pushNamed(context, '/login', arguments: {});
                      } else {
                        Fluttertoast.showToast(
                            msg: "Erreur ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER);
                      }
                    }
                  },
                  child: Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
