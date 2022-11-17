import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workout1/constants.dart';
import 'package:workout1/crud/set_ex_crud.dart';
import 'package:workout1/model/row_set.dart';
import 'package:workout1/model/set_ex.dart';

class row_set_crud {
  static Future<RowSet?> add(RowSet model) async {
    String command = 'INSERT INTO RowSet (trainDayId, ExId) VALUES(?,?);';
    RowSet? ex = RowSet.empty();

    String strPath = await getDatabasesPath();
    String path = join(strPath, dbName);
    Database db = await openDatabase(path, version: 1);

    ex = await db.transaction<RowSet?>((txn) async {
      try {
        int id = await txn.rawInsert(command, [model.trainDayId, model.ExId]);
        List<SetEx> listSetEx = [];
        RowSet? ex1 =
            RowSet(id, model.trainDayId, model.ExId, model.ExName, listSetEx);
        return ex1;
      } catch (e) {
        print(e);
      }
    });
    return ex;
  }

  static Future del(int id) async {
    String delSetEx = 'DELETE FROM SetEx WHERE RowId = ?';
    String command = 'DELETE FROM RowSet WHERE id = ?';
    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int cntSetEx = await db.rawDelete(delSetEx, [id]);
      print('SetEx delete = $cntSetEx ');
      int count = await db.rawDelete(command, [id]);

      print('row delete = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future upd(RowSet model) async {
    String command = 'UPDATE RowSet SET trainDayId = ?, ExId = ? WHERE id = ?';

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int count =
          await db.rawUpdate(command, [model.trainDayId, model.ExId, model.id]);

      print('row updated = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future<List<RowSet>?> getAll(int traynId) async {
    List<RowSet> listRowSet = [];

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);

      Database db = await openDatabase(path, version: 1);

      List<Map> list = await db.rawQuery(
          'SELECT id, trainDayId, ExId, ExName FROM RowSetView WHERE trainDayId = ? ;',
          [traynId]);

      for (int i = 0; i < list.length; i++) {
        int id = list[i]['id'];
        int trainDayId = list[i]['trainDayId'];
        int ExId = list[i]['ExId'];
        String ExName = list[i]['ExName'];

        List<SetEx> listSetex33 = await SetExCrud.getAll(id);
        print(listSetex33);
        RowSet ex = RowSet(id, trainDayId, ExId, ExName, listSetex33);
        print(ex);
        listRowSet.add(ex);
      }
      return listRowSet;
    } catch (e) {
      print(e);
      return null;
    }
    // return listRowSet;
  }
}
