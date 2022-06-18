import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes/sqldb.dart';

class HomeController extends GetxController {
 late List notes=[];
  bool isLoading =true;
  Future  getData() async {
      print('getata');
    List<Map> response = await SqlDb().readData("SELECT * FROM 'note'");
    notes.addAll(response);
    isLoading=false;
     update();



   }
   @override
  void onInit() {

   super.onInit();

   // TODO: implement onInit
  }



}
