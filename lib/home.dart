import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handnote/add_note_page.dart';
import 'package:handnote/details_note.dart';
import 'package:handnote/main.dart';
import 'package:handnote/model_catatan.dart';
import 'package:handnote/routes.dart';
import 'package:handnote/utils.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  final String currentUser;

  const MyHomePage({Key key, this.currentUser}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState(this.currentUser);
}

class _MyHomePageState extends State<MyHomePage> {
  final String currentUser;

  _MyHomePageState(this.currentUser);
  Utils _utils = new Utils();
  List<DocumentSnapshot> _catatanSnapshots;

  Future<void> refresh() async {
    await new Future.delayed(new Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HandNote"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context);
              _utils.signOut().whenComplete(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              }).catchError((e) {
                _utils.tampilToast("Gagal logout akun");
              });
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection("note")
              .where("userId", isEqualTo: currentUser)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              _catatanSnapshots = snapshot.data.documents;
              return _buildList(context, _catatanSnapshots);
            }

            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(SlideRightRoute(
              page: AddNotePage(
            currentUser: currentUser,
            types: "add",
            docId: "",
            judul: "",
            catatan: "",
          )));
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    _catatanSnapshots = snapshot;
    return ListView.builder(
      itemCount: _catatanSnapshots.length,
      itemBuilder: (context, index) {
        return _buildListItem(context, _catatanSnapshots[index]);
      },
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final catatan = Catatan.fromDocument(data);
    //Format Datetime
    var formatter2 = new DateFormat('dd MMM yyyy').add_jm();
    String time = formatter2.format(catatan.time.toDate());
    return Card(
      elevation: 0.0,
      child: ListTile(
        title: Text(catatan.judul),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              catatan.catatan,
              maxLines: 1,
            ),
            Text(time.toString()),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ClipRRect(
                  borderRadius: new BorderRadius.circular(50.0),
                  child: Container(
                    height: 40.0,
                    child: MaterialButton(
                      color: Colors.blue,
                      child: Text(
                        "Detail",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(FadeRouteBuilder(
                            page: DetailsNote(
                          docId: catatan.documentId,
                          judul: catatan.judul,
                          catatan: catatan.catatan,
                        )));
                      },
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: new BorderRadius.circular(50.0),
                  child: Container(
                    height: 40.0,
                    child: MaterialButton(
                      color: Colors.green,
                      child:
                          Text("Edit", style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.of(context).push(SlideRightRoute(
                            page: AddNotePage(
                          currentUser: currentUser,
                          types: "update",
                          docId: catatan.documentId,
                          judul: catatan.judul,
                          catatan: catatan.catatan,
                        )));
                      },
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: new BorderRadius.circular(50.0),
                  child: Container(
                    height: 40.0,
                    child: MaterialButton(
                      color: Colors.red,
                      child:
                          Text("Hapus", style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        showDialog(
                            context: context,
                            child: CupertinoAlertDialog(
                              title: Text("Hapus Catatan"),
                              content: Text(
                                  'Apakah anda yakin menghapus catatan ini?'),
                              actions: <Widget>[
                                new CupertinoDialogAction(
                                  child: Text('Ya'),
                                  onPressed: () {
                                    Firestore.instance
                                        .collection("note")
                                        .document(catatan.documentId)
                                        .delete()
                                        .then((success) {
                                      refresh();
                                      _utils.tampilToast(
                                          "Berhasil menghapus catatan");
                                      Navigator.pop(context);
                                    }).catchError((e) {
                                      _utils.tampilToast(
                                          "Gagal menghapus catatan");
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                                new CupertinoDialogAction(
                                  child: Text('Tidak'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ));
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
