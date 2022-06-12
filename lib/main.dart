import 'package:flutter/material.dart';
import 'package:notes/sqldb.dart';
import 'package:notes/view/home.dart';

void main() async{
  runApp(const MyApp());
 }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
