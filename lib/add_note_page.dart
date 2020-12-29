import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handnote/utils.dart';

class AddNotePage extends StatefulWidget {
  final String currentUser, types, docId, judul, catatan;

  const AddNotePage(
      {Key key,
      this.currentUser,
      this.types,
      this.docId,
      this.judul,
      this.catatan})
      : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState(
      this.currentUser, this.types, this.docId, this.judul, this.catatan);
}

class _AddNotePageState extends State<AddNotePage> {
  final String currentUser, types, docId, judul, catatan;
  TextEditingController judulController = TextEditingController();
  TextEditingController catatanController = TextEditingController();
  Utils _utils = Utils();
  bool loading = false;

  _AddNotePageState(
      this.currentUser, this.types, this.docId, this.judul, this.catatan);

  Future<void> validationSave() async {
    if (judulController.text == "") {
      _utils.tampilToast("Judul catatan masih kosong!");
    } else if (catatanController.text == "") {
      _utils.tampilToast("Catatan masih kosong!");
    } else {
      if (types == "add") {
        save();
      } else {
        update();
      }
    }
  }

  save() {
    setState(() {
      loading = true;
    });
    Firestore.instance.collection("note").document().setData({
      'userId': currentUser,
      'judul': judulController.text,
      'catatan': catatanController.text,
      'types': 'teks',
      'timestamp': DateTime.now()
    }).then((succes) {
      setState(() {
        loading = false;
        judulController.clear();
        catatanController.clear();
      });
      _utils.tampilToast("Berhasil membuat catatan");
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      _utils.tampilToast("Gagal membuat catatan");
    });
  }

  update() {
    setState(() {
      loading = true;
    });
    Firestore.instance.collection("note").document(docId).updateData({
      'judul': judulController.text,
      'catatan': catatanController.text,
    }).then((succes) {
      setState(() {
        loading = false;
        judulController.clear();
        catatanController.clear();
      });
      Navigator.pop(context);
      _utils.tampilToast("Berhasil memperbarui catatan");
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      _utils.tampilToast("Gagal memperbarui catatan");
    });
  }

  Widget loadingProgress() {
    return Scaffold(
      body: Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.grey,
      )),
    );
  }

  @override
  void initState() {
    judulController.text = judul;
    catatanController.text = catatan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? loadingProgress()
        : Scaffold(
            appBar: AppBar(
              title: Text("Buat Catatan Baru"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    validationSave();
                  },
                )
              ],
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      ClipRRect(
                        borderRadius: new BorderRadius.circular(10.0),
                        child: new TextFormField(
                          controller: judulController,
                          decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.all(15.0),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.title, size: 20.0),
                              hintText: "Judul Catatan",
                              filled: true),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ClipRRect(
                        borderRadius: new BorderRadius.circular(10.0),
                        child: new TextFormField(
                          maxLines: 50,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          controller: catatanController,
                          decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.all(15.0),
                              border: InputBorder.none,
                              filled: true),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
