import 'package:flutter/material.dart';
import 'package:handnote/daftar.dart';
import 'package:handnote/login.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("HandNote"),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: false,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: <Widget>[
                new Tab(
                  text: "LOGIN",
                ),
                new Tab(
                  text: "DAFTAR",
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[Login(), Daftar()],
          ),
        ));
  }
}
