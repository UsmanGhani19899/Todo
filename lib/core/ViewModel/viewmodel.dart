import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/model/todo_model.dart';
import 'package:todo/core/service/api.dart';
import 'package:todo/locator.dart';

class CrudModel with ChangeNotifier {
  Api _api = getit<Api>();

  List<Todo>? todos;

  Future<List<Todo>?> fetchData() async {
    var result = await _api.getDataCollection();
    todos = result.docs
        .map((doc) => Todo.fromMap(doc.data() as Map, doc.id))
        .toList();
    return todos;
  }

  Stream<QuerySnapshot> getStreamCollectionData() {
    return _api.streamFetchedData();
  }

  Future<Todo> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Todo.fromMap(doc.data() as Map, doc.id);
  }

  Future removeByUserId(String id) async {
    await _api.removeById(id);
  }

  Future updateDataById(Todo data, String id) async {
    await _api.updateById(id, data.toJson());
    return;
  }

  Future addUserDocument(Todo data) async {
    var result = await _api.addDocument(data.toJson());
    return;
  }
}
