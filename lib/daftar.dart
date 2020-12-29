import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handnote/home.dart';
import 'package:handnote/routes.dart';
import 'package:handnote/utils.dart';

class Daftar extends StatefulWidget {
  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  TextEditingController displayNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  Utils _utils = new Utils();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool loading = false;

  Future<void> daftarBtn() async {
    if (displayNameController.text == "") {
      _utils.tampilToast("Nama lengkap mohon dilengkapi");
    } else if (emailController.text == "") {
      _utils.tampilToast("Email mohon dilengkapi");
    } else if (passwordController.text == "") {
      _utils.tampilToast("Sandi mohon diisi");
    } else if (passwordController.text.length < 5) {
      _utils.tampilToast("Sandi harus lebih dari 5 karakter");
    } else {
      daftarAction();
    }
  }

  Future<void> daftarAction() async {
    setState(() {
      loading = true;
    });
    try {
      user = (await _auth.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text))
          .user;
    } catch (e) {} finally {
      if (user != null) {
        var userId = user.uid;
        Firestore.instance.collection("users").document(userId).setData({
          'userId': userId,
          'displayName': displayNameController.text,
          'timestamp': DateTime.now()
        }).then((succes) {
          _utils.tampilToast("Berhasil mendaftar");
          Navigator.of(context).pushReplacement(SlideRightRoute(
              page: MyHomePage(
            currentUser: user.uid,
          )));
        }).catchError((e) {
          setState(() {
            loading = false;
          });
          _utils.tampilToast("Gagal mendaftar");
        });
      } else {
        setState(() {
          loading = false;
        });
        _utils.tampilToast("Gagal mendaftar");
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
                    controller: displayNameController,
                    decoration: new InputDecoration(
                        contentPadding: const EdgeInsets.all(15.0),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person, size: 20.0),
                        hintText: "Nama",
                        filled: true),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 10.0),
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
                    child: Text("DAFTAR"),
                    onPressed: () {
                      daftarBtn();
                    },
                  ),
                )
              ],
            ),
          );
  }
}
