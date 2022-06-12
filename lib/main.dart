import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/sqldb.dart';
import 'package:notes/view/home.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
 }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   GetMaterialApp(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      home:  Home(),
    );
  }
}
