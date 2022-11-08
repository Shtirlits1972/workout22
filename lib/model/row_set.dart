import 'package:workout1/model/set_ex.dart';

class RowSet {
  int id = 0;
  int trainDayId = 0;
  int ExId = 0;
  String ExName = '';
  List<SetEx> listSetex = [];

  RowSet(this.id, this.trainDayId, this.ExId, this.ExName, this.listSetex);
  RowSet.empty();

  @override
  String toString() {
    return 'id = $id, trainDayId = $trainDayId, ExId = $ExId, ExName = $ExName, listSetex = $listSetex';
  }
}
