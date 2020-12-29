import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handnote/home.dart';
import 'package:handnote/routes.dart';
import 'package:handnote/utils.dart';
import 'package:handnote/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HandNote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthentikasiPage(),
    );
  }
}

class AuthentikasiPage extends StatefulWidget {
  @override
  _AuthentikasiPageState createState() => _AuthentikasiPageState();
}

class _AuthentikasiPageState extends State<AuthentikasiPage> {
  Utils _utils = new Utils();
  @override
  void initState() {
    super.initState();
    new Timer(const Duration(milliseconds: 2000), () {
      _utils.getUser().then((user) {
        if (user != null) {
          Navigator.of(context)
              .pushReplacement(SlideLeftRoute(page: MyHomePage(currentUser: user.uid,)));
        } else {
          Navigator.of(context)
              .pushReplacement(SlideRightRoute(page: Welcome()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.grey,
      )),
    ));
  }
}
