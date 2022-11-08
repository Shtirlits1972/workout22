import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workout1/constants.dart';
import 'package:workout1/model/exercise.dart';

class exCrud {
  static Future<exercise> add(String NameEx) async {
    String command = 'INSERT INTO exercise (NameEx) values(?);';
    exercise ex = exercise.empty();

    String strPath = await getDatabasesPath();
    String path = join(strPath, dbName);
    Database db = await openDatabase(path, version: 1);

    ex = await db.transaction<exercise>((txn) async {
      int id = await txn.rawInsert(command, [NameEx]);
      exercise ex1 = exercise(id, NameEx);
      return ex1;
    });
    return ex;
  }

  static Future del(int id) async {
    String command = 'DELETE FROM exercise WHERE id = ?';
    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int count = await db.rawDelete(command, [id]);

      print('row delete = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future upd(int id, String NameEx) async {
    String command = 'UPDATE exercise SET NameEx = ? WHERE id = ?';

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int count = await db.rawUpdate(command, [NameEx, id]);

      print('row updated = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future<List<exercise>> getAll() async {
    List<exercise> listEx = [];

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);

      Database db = await openDatabase(path, version: 1);

      List<Map> list = await db.rawQuery('SELECT id, NameEx FROM exercise ;');

      for (int i = 0; i < list.length; i++) {
        int id = list[i]['id'];
        String NameEx = list[i]['NameEx'];
        exercise ex = exercise(id, NameEx);
        listEx.add(ex);
      }
    } catch (e) {
      print(e);
    }
    return listEx;
  }
}
