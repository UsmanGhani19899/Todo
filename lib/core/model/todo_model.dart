import 'package:flutter/material.dart';

class Todo {
  String? id;
  String? content;

  Todo({this.content, this.id});

  Todo.fromMap(Map snapshot, String id)
      : id = id,
        content = snapshot["content"] ?? "";

  toJson() {
    return {
      "content": content,
    };
  }
}
