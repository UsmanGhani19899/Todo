import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/Screens/show.dart';
import 'package:todo/core/ViewModel/viewmodel.dart';
import 'package:todo/core/model/todo_model.dart';

class TodoHome extends StatefulWidget {
  final Todo? todos;
  TodoHome({this.todos});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  @override
  String? content;
  late List<Todo> todos;

  Widget build(BuildContext context) {
    var providerData = Provider.of<CrudModel>(context);
    final _formkey = GlobalKey<FormState>();
    void showDialogBox() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Form(
                key: _formkey,
                child: TextFormField(
                  decoration: InputDecoration(hintText: "Type your Todo"),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Something";
                    }
                  },
                  onSaved: (val) => content = val,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.openSans(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      Navigator.pop(context);
                      await providerData
                          .addUserDocument(Todo(content: content!));
                    }
                  },
                  child: Text(
                    "Add",
                    style: GoogleFonts.openSans(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            );
          });
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          onPressed: () {
            showDialogBox();
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "MY TODO",
            style: GoogleFonts.openSans(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        body: StreamBuilder(
          stream: providerData.getStreamCollectionData(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              todos = snapshot.data!.docs
                  .map((doc) =>
                      Todo.fromMap(doc.data() as Map<String, dynamic>, doc.id))
                  .toList();
              if (todos.isEmpty) {
                return Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.list_alt_outlined,
                          color: Colors.grey,
                          size: 100,
                        ),
                        Text(
                          "Add Your Todos Here",
                          style: GoogleFonts.openSans(color: Colors.grey),
                        )
                      ],
                    ));
              }
            }

            return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ShowData(
                    todos: todos[index],
                  );
                });
          },
        ),
      ),
    );
  }
}
