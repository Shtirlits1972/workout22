import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workout1/constants.dart';

class InitCrud {
  static init() async {
    String exerciseTab = 'CREATE TABLE [exercise](  ' +
        '[id] INTEGER PRIMARY KEY AUTOINCREMENT,  ' +
        '[NameEx] NVARCHAR  );  ';

    String traynDay = 'CREATE TABLE [train_day](  ' +
        '[id] INTEGER PRIMARY KEY AUTOINCREMENT,  ' +
        '[data] DATETIME NOT NULL );  ';

    String RowSet = 'CREATE TABLE [RowSet](  ' +
        '[id] INTEGER PRIMARY KEY AUTOINCREMENT,  ' +
        '[trainDayId] INT, [ExId] INT );  ';

    String SetEx = 'CREATE TABLE [SetEx](  ' +
        '[id] INTEGER PRIMARY KEY AUTOINCREMENT,  ' +
        '[RowId] INT, [weight] DOUBLE DEFAULT 0, [qty] INT DEFAULT 0);  ';

    String RowSetView = 'CREATE VIEW RowSetView AS  ' +
        'SELECT R.id, R.trainDayId, R.ExId,  ' +
        'IFNULL(E.NameEx, \'\') as ExName  ' +
        'FROM RowSet R   ' +
        'LEFT JOIN exercise E ON E.id = R.ExId;';

    getDatabasesPath().then((String strPath) {
      String path = join(strPath, dbName);
      try {
        final database = openDatabase(path, onCreate: (db, version) async {
          db.execute(exerciseTab);

          db.execute(traynDay);
          db.execute(RowSet);
          db.execute(SetEx);
          db.execute(RowSetView);

          print('DB created');
        }, version: 1);
      } catch (e) {
        print(e);
      }
    });
  }
}
