import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handnote/home.dart';
import 'package:handnote/lupa.dart';
import 'package:handnote/routes.dart';
import 'package:handnote/utils.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  Utils _utils = new Utils();
  FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

  Future<void> loginBtn() async {
    if (emailController.text == "") {
      _utils.tampilToast("Mohon lengkapi email");
    } else if (passwordController.text == "") {
      _utils.tampilToast("Mohon lengkapi sandi");
    } else if (passwordController.text.length < 5) {
      _utils.tampilToast("Sandi harus lebih dari 5 karakter");
    } else {
      loginAction();
    }
  }

  loginAction() async {
    setState(() {
      loading = true;
    });
    try {
      user = (await _auth.signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text))
          .user;
    } catch (e) {} finally {
      String currentuser= user.uid;
      if (user != null) {
        Navigator.of(context).pushReplacement(
            SlideLeftRoute(page: MyHomePage(currentUser: currentuser)));
      } else {
        setState(() {
          loading = false;
        });
        _utils.tampilToast("Gagal login");
      }
    }
  }

  Widget loadingProgress() {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: Colors.grey,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? loadingProgress()
        : Container(
            margin: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "HandNote",
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                ClipRRect(
                  borderRadius: new BorderRadius.circular(20.0),
                  child: new TextFormField(
                    controller: emailController,
                    decoration: new InputDecoration(
                        contentPadding: const EdgeInsets.all(15.0),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.mail_outline, size: 20.0),
                        hintText: "Email",
                        filled: true),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 10.0),
                ),
                ClipRRect(
                  borderRadius: new BorderRadius.circular(20.0),
                  child: new TextFormField(
                    controller: passwordController,
                    decoration: new InputDecoration(
                        contentPadding: const EdgeInsets.all(15.0),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock_outline, size: 20.0),
                        hintText: "Sandi",
                        filled: true),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 10.0),
                ),
                ClipRRect(
                  borderRadius: new BorderRadius.circular(20.0),
                  child: CupertinoButton(
                    color: Colors.blue,
                    child: Text("LOGIN"),
                    onPressed: () {
                      loginBtn();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: FlatButton(
                    child: Text(
                      "Lupa sandi",
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(SlideLeftRoute(page: LupaSandi()));
                    },
                  ),
                )
              ],
            ),
          );
  }
}
