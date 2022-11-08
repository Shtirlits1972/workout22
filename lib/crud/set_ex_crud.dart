import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workout1/constants.dart';
import 'package:workout1/model/set_ex.dart';

class SetExCrud {
  static Future<SetEx> add(SetEx setEx) async {
    String command = 'INSERT INTO SetEx (RowId, weight, qty) values(?, ?, ?);';
    SetEx ex = SetEx.empty();

    String strPath = await getDatabasesPath();
    String path = join(strPath, dbName);
    Database db = await openDatabase(path, version: 1);

    ex = await db.transaction<SetEx>((txn) async {
      int id =
          await txn.rawInsert(command, [setEx.RowId, setEx.weight, setEx.qty]);
      SetEx stE = SetEx(id, setEx.RowId, setEx.weight, setEx.qty);
      return stE;
    });
    return ex;
  }

  static Future del(int id) async {
    String command = 'DELETE FROM SetEx WHERE id = ?';
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

  static Future upd(SetEx setEx) async {
    String command =
        'UPDATE SetEx SET RowId = ?, weight = ?, qty = ? WHERE id = ?';

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int count = await db
          .rawUpdate(command, [setEx.RowId, setEx.weight, setEx.qty, setEx.id]);

      print('row updated = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future<List<SetEx>> getAll(int RowId) async {
    List<SetEx> listSetEx = [];

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);

      Database db = await openDatabase(path, version: 1);

      List<Map> list = await db.rawQuery(
          'SELECT id, RowId, weight, qty FROM SetEx WHERE RowId = ? ;',
          [RowId]);

      for (int i = 0; i < list.length; i++) {
        int id = list[i]['id'];
        //  int RowId = list[i]['RowId'];
        double weight = list[i]['weight'];
        int qty = list[i]['qty'];

        SetEx setEx = SetEx(id, RowId, weight, qty);
        listSetEx.add(setEx);
      }
    } catch (e) {
      print(e);
    }
    return listSetEx;
  }
}
