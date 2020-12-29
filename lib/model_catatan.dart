import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class Catatan {
  String documentId, userCreate, judul, catatan;
  Timestamp time;

  Catatan(
      {this.userCreate, this.documentId, this.judul, this.catatan, this.time});

  Catatan.fromDocument(DocumentSnapshot doc) {
    documentId = doc.documentID;
    userCreate = doc["userId"];
    judul = doc["judul"];
    catatan = doc["catatan"];
    time = doc["timestamp"];
  }
}
