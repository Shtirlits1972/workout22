import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workout1/constants.dart';
import 'package:workout1/crud/row_set_crud.dart';
import 'package:workout1/model/row_set.dart';
import 'package:workout1/model/trayn_day.dart';

class train_day_crud {
  static Future<train_day?> add(DateTime data) async {
    String command = 'INSERT INTO train_day ([data]) VALUES(?);';
    train_day? ex = train_day.empty();

    String strPath = await getDatabasesPath();
    String path = join(strPath, dbName);
    Database db = await openDatabase(path, version: 1);

    ex = await db.transaction<train_day?>((txn) async {
      try {
        int id = await txn.rawInsert(command, [data.toString()]);
        train_day? ex1 = train_day(id, data);
        return ex1;
      } catch (e) {
        print(e);
      }
    });
    return ex;
  }

  static Future del(int id) async {
    String command = 'DELETE FROM train_day WHERE id = ?';
    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      List<RowSet>? lstRowSet = await row_set_crud.getAll(id);

      if (lstRowSet != null) {
        for (int i = 0; i < lstRowSet.length; i++) {
          row_set_crud.del(lstRowSet[i].id);
        }
      }

      int count = await db.rawDelete(command, [id]);

      print('row delete = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future upd(int id, DateTime data) async {
    String command = 'UPDATE train_day SET data = ? WHERE id = ?';

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int count = await db.rawUpdate(command, [data, id]);

      print('row updated = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future<List<train_day>> getAll() async {
    List<train_day> listDays = [];

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);

      Database db = await openDatabase(path, version: 1);

      List<Map> list = await db
          .rawQuery('SELECT id, [data] FROM train_day ORDER BY [data] ;');

      for (int i = 0; i < list.length; i++) {
        int id = list[i]['id'];
        DateTime data = DateTime.parse(list[i]['data'].toString());

        train_day ex = train_day(id, data);
        listDays.add(ex);
      }
    } catch (e) {
      print(e);
    }
    return listDays;
  }
}
