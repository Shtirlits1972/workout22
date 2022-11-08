import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout1/model/trayn_day.dart';

class KeeperTraynDay {
  List<train_day> listDays = [];
}

class DataCubitDays extends Cubit<KeeperTraynDay> {
  List<train_day> get getExercise => state.listDays;

  setExercise(List<train_day> newList) {
    state.listDays = newList;
  }

  add(train_day day) {
    state.listDays.add(day);
  }

  del(int id) {
    for (int i = 0; i < state.listDays.length; i++) {
      if (state.listDays[i].id == id) {
        state.listDays.removeAt(i);
        break;
      }
    }
  }

  DataCubitDays(KeeperTraynDay initState) : super(initState);
}
