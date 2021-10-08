import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Api {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference? ref;
  final String path;

  Api(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref!.get();
  }

  Stream<QuerySnapshot> streamFetchedData() {
    return ref!.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref!.doc(id).get();
  }

  Future<void> removeById(String id) {
    return ref!.doc(id).delete();
  }

  Future<void> updateById(String id, Map<String, Object?> data) {
    return ref!.doc(id).update(data);
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref!.add(data);
  }
}
