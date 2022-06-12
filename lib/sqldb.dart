import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static   Database ?_db;

  Future<Database? > get db async {
    if (_db == null) {
     _db= await initialDb();
     return _db;

    } else {
      return _db;
    }
   }

  initialDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'notes.db');
    print(path);
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version:5, onUpgrade: _onUpgrade);
    return myDb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion)async {
    await db.execute("ALTER TABLE note ADD COLUMN title TEXT");
    print('OnUpgrade');
  }

  _onCreate(Database db, int version) async {
    String sql = '''
    CREATE TABLE note ( id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                         note TEXT NOT NULL )
    ''';
    await db.execute(sql);
    print('onCreate');
  }

  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? myDb = await db;
    int  response = await myDb !.rawInsert(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }
  deleteDatabaseMod()async{
    String databasePath=await getDatabasesPath();
    String path=join(databasePath,'notes.db');
    await deleteDatabase(path);

  }
}
