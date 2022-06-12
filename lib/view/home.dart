import 'package:flutter/material.dart';
import 'package:notes/sqldb.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  Future<List<Map>> getData() async {
    List<Map> response = await SqlDb().readData("SELECT * FROM 'note'");
    return response;
  }

  @override
  Widget build(BuildContext context) {


    List<Map>? data;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Column(
        children: [
          // FutureBuilder(
          //   future: getData(),
          //   builder: (context, AsyncSnapshot<List<Map>> snapShot) {
          //     if (snapShot. hasData) {
          //       return ListView.builder(
          //         physics: NeverScrollableScrollPhysics(),
          //         shrinkWrap: true,
          //         itemCount: snapShot.data!.length,
          //         itemBuilder: (context, index) {
          //           return Text('${snapShot.data![index]}');
          //         },
          //       );
          //     } else {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () async {
                    int response = await SqlDb().insertData(
                        "INSERT INTO 'note' ('note') VALUES ('Asmaa Note')");
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
                    data = await SqlDb().readData("SELECT * FROM 'note' ");
                    print(data);
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
                        "UPDATE 'note' SET note='Asmaa Akram Helmy' WHERE id =10");
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
                        .deleteData("DELETE FROM 'note' WHERE id=10");
                    print(response);
                  },
                  child: Text('DELETE Data'),
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      color: Colors.pink, child: Center(child: Text('$data'))),
                ),
                Expanded(
                  child: Container(
                      color: Colors.orange, child: Center(child: Text('Note'))),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
