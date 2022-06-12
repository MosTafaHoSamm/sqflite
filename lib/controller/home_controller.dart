import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes/sqldb.dart';

class HomeController extends GetxController {
  Future<List<Map>> getData() async {
    List<Map> response = await SqlDb().readData("SELECT * FROM 'note'");
    update();

    return response;
  }



}
