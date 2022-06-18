import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:notes/controller/home_controller.dart';
import 'package:notes/sqldb.dart';

import '../shared/components.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController title = TextEditingController();

  TextEditingController note = TextEditingController();

  TextEditingController color = TextEditingController();

  GlobalKey formKey = GlobalKey<FormState>();
  GlobalKey formKey2 = GlobalKey<FormState>();
  late List notes;

  bool isLoading = true;

  Future getData() async {
    notes = [];
    print('getata');
    // List<Map> response = await SqlDb().readData("SELECT * FROM 'note'");
    List<Map> response=await SqlDb().read("note");
    notes.addAll(response);

    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  // Future<List<Map>> getData() async {
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(' length${notes.length}');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            Container(
              color: Colors.white,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      textForm(
                          icon: Icons.bookmark,
                          text: 'Title',
                          controller: title),
                      textForm(
                          icon: Icons.task, text: 'note', controller: note),
                      textForm(
                          icon: Icons.color_lens,
                          text: 'color',
                          controller: color),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Add Note'),
                          IconButton(
                              onPressed: () async {
                                // int response = await SqlDb().insertData('''
                                //    INSERT INTO note ('title','note','color')
                                //    VALUES('${title.text}','${note.text}','${color.text}')
                                //    ''');
                                int response= await SqlDb().insert("note",
                                    {
                                      'title':'${title.text}',
                                      'note':'${note.text}',
                                      'color':'${color.text}'

                                    });
                                if (response > 0) {
                                  getData();
                                  Get.back();
                                }
                              },
                              icon: Icon(Icons.add_task_rounded)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
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
                  return notes.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 10,
                                color: Colors.amberAccent,
                                child: ListTile(
                                    style: ListTileStyle.drawer,
                                    title: Text(' ${notes[index]['title']}'),
                                    subtitle: Row(
                                      children: [
                                        Text('${notes[index]['note']}'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          '${notes[index]['color']}',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            title.text = notes[index]['title'];
                                            note.text = notes[index]['note'];
                                            color.text = notes[index]['color'];
                                            Get.bottomSheet(Container(
                                              color: Colors.white,
                                              child: SingleChildScrollView(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                child: Form(
                                                  key: formKey2,
                                                  child: Column(
                                                    children: [
                                                      textForm(
                                                          icon: Icons.bookmark,
                                                          text: 'Title',
                                                          controller: title),
                                                      textForm(
                                                          icon: Icons.task,
                                                          text: 'note',
                                                          controller: note),
                                                      textForm(
                                                          icon:
                                                              Icons.color_lens,
                                                          text: 'color',
                                                          controller: color),
                                                      MaterialButton(
                                                        color: Colors
                                                            .amber.shade700,
                                                        onPressed: () async {
                                                          // int response =
                                                          //     await SqlDb()
                                                          //         .updateData(
                                                          //             '''
                                                          //
                                                          // UPDATE  `note`  SET
                                                          // `title`='${title.text}',
                                                          // `note`='${note.text}',
                                                          // `color`='${color.text}'
                                                          // WHERE `id` ="${notes[index]['id']}"
                                                          //
                                                          // ''');
                                                          int response =await SqlDb().update("note", "id=${notes[index]['id']}",
                                                              {
                                                                'note':'${note.text}',
                                                                'title':"${title.text}",
                                                                "color":'${color.text}'
                                                              });
                                                          if(response>0)
                                                            {
                                                              getData();
                                                              Get.back();

                                                            }
                                                        },
                                                        child: Text(
                                                          'Edit Note',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            // int response = await SqlDb().deleteData(
                                            //     "DELETE FROM 'note' WHERE id=${notes[index]['id']}");
                                            int response = await SqlDb().delete('note', 'id=${notes[index]['id']}');
                                            print(response);
                                            if (response == 1) {
                                              notes.removeWhere((element) =>
                                                  element['id'] ==
                                                  notes[index]['id']);
                                              setState(() {});
                                            }
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
