import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handnote/utils.dart';

class LupaSandi extends StatefulWidget {
  @override
  _LupaSandiState createState() => _LupaSandiState();
}

class _LupaSandiState extends State<LupaSandi> {
  TextEditingController emailController = TextEditingController();
  Utils _utils = new Utils();

  Future<void> resetBtn() async {
    if (emailController.text == "") {
      _utils.tampilToast("Mohon isi email");
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Lupa Sandi"),
        centerTitle: true,
        titleSpacing: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                Text(
                  "Kami hanya membutuhkan email yang telah terdaftar di waron.id untuk mengirimkan intruksi reset sandi",
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10.0,
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
                  child: CupertinoButton(
                    color: Colors.blue,
                    child: Text("RESET SANDI"),
                    onPressed: () {
                      resetBtn();
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
