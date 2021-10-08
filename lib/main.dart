import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Screens/splashscreen.dart';
import 'package:todo/Screens/todo_home.dart';
import 'package:todo/core/ViewModel/viewmodel.dart';
import 'package:todo/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  showLocator();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getit<CrudModel>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
