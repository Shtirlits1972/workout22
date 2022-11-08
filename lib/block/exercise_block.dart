import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout1/model/exercise.dart';

class KeeperEx {
  List<exercise> listEx = [];
}

class DataCubitEx extends Cubit<KeeperEx> {
  List<exercise> get getExercise => state.listEx;

  setExercise(List<exercise> newList) {
    state.listEx = newList;
  }

  add(exercise ex) {
    state.listEx.add(ex);
  }

  del(int id) {
    for (int i = 0; i < state.listEx.length; i++) {
      if (state.listEx[i].id == id) {
        state.listEx.removeAt(i);
        break;
      }
    }
  }

  DataCubitEx(KeeperEx initState) : super(initState);
}
