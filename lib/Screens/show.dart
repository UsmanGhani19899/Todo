// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/ViewModel/viewmodel.dart';
import 'package:todo/core/model/todo_model.dart';

class ShowData extends StatelessWidget {
  final Todo? todos;
  ShowData({this.todos});

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    String? content;
    var providerData = Provider.of<CrudModel>(context);

    void updatePop() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Form(
                  key: _formkey,
                  child: TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter something";
                      }
                    },
                    onSaved: (val) => content = val,
                  )),
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
                      await providerData.updateDataById(
                          Todo(content: content), todos!.id!);
                    }
                  },
                  child: Text(
                    "Update",
                    style: GoogleFonts.openSans(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            );
          });
    }

    return Container(
      child: Dismissible(
          key: ValueKey(todos!.id!),
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            color: Colors.red,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            Provider.of<CrudModel>(context, listen: false)
                .removeByUserId(todos!.id!);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.15))),
            height: MediaQuery.of(context).size.height * 0.13,
            child: ListTile(
              title: Text(todos!.content!,
                  style: GoogleFonts.openSans(
                      color: Colors.black, fontWeight: FontWeight.w600)),
              trailing: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(25)),
                child: IconButton(
                    onPressed: () {
                      updatePop();
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    )),
              ),
              // IconButton(
              //     onPressed: () {
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return AlertDialog(
              //               title: Text("Are you sure?"),
              //               actions: [
              //                 TextButton(
              //                   onPressed: () {
              //                     Navigator.pop(context);
              //                   },
              //                   child: Text("Cancel"),
              //                 ),
              //                 TextButton(
              //                   onPressed: () async {
              //                     Navigator.pop(context);
              //                     await providerData
              //                         .removeByUserId(todos!.id!);
              //                   },
              //                   child: Text("ok"),
              //                 ),
              //               ],
              //             );
              //           });
              //     },
              //     icon: Icon(
              //       Icons.delete,
              //       color: Colors.black,
              //     )),
            ),
          )),
    );
  }
}
