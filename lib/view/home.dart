  import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:notes/controller/home_controller.dart';
import 'package:notes/sqldb.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  // Future<List<Map>> getData() async {
  //   List<Map> response = await SqlDb().readData("SELECT * FROM 'note'");
  //   return response;
  // }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       floatingActionButton: FloatingActionButton(
         onPressed: (){},
         child: Icon(Icons.add),
       ),
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
               child: GetBuilder<HomeController>(
                init: HomeController(),
                builder: (controller) {
                  return FutureBuilder(
                    future: controller.getData(),
                    builder: (context, AsyncSnapshot<List<Map>> snapShot) {
                      if (snapShot.hasData) {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapShot.data!.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              onDismissed: (vv){
                                SqlDb().deleteData("DELETE FROM note Where id =${snapShot.data![index]['id']}");
                              },
                              key:  Key('${snapShot.data![index]['id']}' ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: ListTile(
                                    style: ListTileStyle.drawer,
                                    tileColor: Colors.grey,

                                    title: Text(' ${snapShot.data![index]['id']}'),
                                    subtitle: Text('${snapShot.data![index]['note']}'),
                                    trailing: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.pink,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 15,
                                        child: Text('${snapShot.data![index]['id']}'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () async {
                    int response = await SqlDb().insertData(
                        "INSERT INTO 'note' ('note','title') VALUES ('Asmaa Note','Samasemo')");
                    print(response);
                  },
                  child: Text('Insert Data'),
                )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.greenAccent)),
                  onPressed: () async {

                  },
                  child: Text('Get Data'),
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () async {
                    int response = await SqlDb().updateData(
                        "UPDATE 'note' SET note='Asmaa Akram Helmy' WHERE id =27}");
                    print(response);
                  },
                  child: Text('Update Data'),
                )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.greenAccent)),
                  onPressed: () async {
                    int response = await SqlDb()
                        .deleteData("DELETE FROM 'note' WHERE id=28 }");
                    print(response);
                  },
                  child: Text('DELETE Data'),
                )),
                Expanded(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue)),
                  onPressed: () async {
                     await SqlDb().deleteDatabaseMod();

                   },
                  child: Text('DELETE Database'),
                )),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
