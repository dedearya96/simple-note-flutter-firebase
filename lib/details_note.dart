import 'package:flutter/material.dart';
import 'package:handnote/add_note_page.dart';
import 'package:handnote/ads.dart';
import 'package:handnote/routes.dart';
import 'package:handnote/utils.dart';

class DetailsNote extends StatefulWidget {
  final String docId, judul, catatan;

  const DetailsNote({Key key, this.docId, this.judul, this.catatan})
      : super(key: key);
  @override
  _DetailsNoteState createState() =>
      _DetailsNoteState(this.docId, this.judul, this.catatan);
}

class _DetailsNoteState extends State<DetailsNote> {
  final String docId, judul, catatan;
  _DetailsNoteState(this.docId, this.judul, this.catatan);
  Utils _utils = Utils();
  String currentUser = "";

  @override
  void initState() {
    Ads.showInterstitialAd();
    _utils.getUser().then((user) {
      if (user != null) {
        currentUser = user.uid;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text(judul),
        
      ),
      body: ListView(
        children: <Widget>[
          Container(margin: EdgeInsets.all(5.0), child: Text(catatan)),
        ],
      ),
     
    );
  }
}
