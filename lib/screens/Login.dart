import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
                child:
                    Image.asset('assets/image/01.png', height: 450, width: 450),
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
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      print(emailController.text);
                      print(passwordController.text);
                      Fluttertoast.showToast(
                        msg: "Champs obligatoire",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                    } else if (!EmailValidator.validate(emailController.text)) {
                      Fluttertoast.showToast(
                        msg: "Email not valid",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                      print(passwordController.text);
                    } else if (passwordController.text.length < 8) {
                      Fluttertoast.showToast(
                        msg: "Password too short",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                    } else {
                      print(passwordController.text); //contrle les changements
                      print(emailController.text);

                      var url = Uri.parse(
                          'https://api-nodejs-todolist.herokuapp.com/user/login');
                      var myBody = {
                        "email": emailController.text,
                        "password": passwordController.text,
                      };
                      var reponse = await http.post(url,
                          body: jsonEncode(myBody),
                          headers: {"content-Type": "application/json"});

                      if (reponse.statusCode == 200) {
                        var bodReponse =
                            jsonDecode((reponse.body)); // décodage du token
                        print(bodReponse['token']);

                        final prefs = await SharedPreferences
                            .getInstance(); // for save token in base interne
                        prefs.setString('token', bodReponse['token']);
                        Navigator.pushNamed(context, '/home', arguments: {});
                      } else {
                        Fluttertoast.showToast(
                            msg: "Erreur ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER);
                      }
                      // Navigator.pushNamed(context, '/home', arguments: {
                      //   'password': passwordController.text,
                      //   'email': emailController.text,
                      // });
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/NewAcc', arguments: {});
                  },
                  child: Text('Create Account',
                      style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
