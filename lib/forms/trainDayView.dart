import 'package:flutter/material.dart';
import 'package:workout1/constants.dart';
import 'package:workout1/crud/row_set_crud.dart';
import 'package:workout1/crud/set_ex_crud.dart';
import 'package:workout1/forms/set_ex_add.dart';
import 'package:workout1/model/exercise.dart';
import 'package:workout1/model/row_set.dart';
import 'package:workout1/model/set_ex.dart';
import 'package:workout1/model/trayn_day.dart';

class TrainDayView extends StatefulWidget {
  TrainDayView({Key? key, required this.day}) : super(key: key);
  train_day day;
  @override
  _TrainDayViewState createState() => _TrainDayViewState();
}

class _TrainDayViewState extends State<TrainDayView> {
  List<RowSet> listRowSet = [];

  @override
  Widget build(BuildContext context) {
    row_set_crud.getAll(widget.day.id).then((value) {
      setState(() {
        if (value != null) {
          listRowSet = value;
        }
      });
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add new Exercise'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushNamed(context, '/ExListSelect').then((value) {
                if (value != null) {
                  exercise ex = value as exercise;
                  List<SetEx> listSetEx = [];
                  RowSet rowSet =
                      RowSet(0, widget.day.id, ex.id, ex.NameEx, listSetEx);
                  row_set_crud.add(rowSet).then((value2) {
                    setState(() {
                      listRowSet.add(value2!);
                    });

                    print('value2 = $value2');
                  });
                }
              });

              setState(() {
                //
              });
            },
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Add new Train',
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                dataFormat.format(widget.day.data),
                style: txt15,
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                itemCount: listRowSet.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listRowSet[index].ExName,
                                style: txt20,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              print('Add one time');
                              RowSet rowSet1 = listRowSet[index];
                              Navigator.pushNamed(context, '/SetExAdd',
                                      arguments: rowSet1)
                                  .then((value) {
                                if (value != null) {
                                  SetEx setEx = value as SetEx;
                                  // value.RowId = listRowSet[index].id;
                                  SetExCrud.add(setEx).then((value2) {
                                    setState(() {
                                      listRowSet[index].listSetex.add(setEx);
                                      print(value2);
                                    });
                                  });
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Warning!'),
                                    content:
                                        const Text('Do you want to delete?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                ).then((value) {
                                  if (value! == true) {
                                    print(value);
                                    row_set_crud
                                        .del(listRowSet[index].id)
                                        .then((value) {
                                      setState(() {
                                        if (listRowSet.length > 0 &&
                                            listRowSet != null &&
                                            listRowSet.length > index) {
                                          listRowSet.removeAt(index);
                                        } else {
                                          print('error');
                                        }
                                      });
                                    });
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 30,
                                color: Colors.black26,
                              )),
                        ],
                      ),
                      getSetExRow(listRowSet[index].listSetex),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getSetExRow(List<SetEx> list) {
    List<Widget> lstWidget = [];

    Text txt00 = Text(
      'KG',
      style: txt15,
    );
    Divider dv00 = const Divider(
      color: Colors.black,
      thickness: 1.0,
      height: 1,
      indent: 1,
      endIndent: 0,
    );

    SizedBox sb00 = new SizedBox(
      width: 20,
      height: 1.0,
      child: new Center(
        child: new Container(
          margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
          height: 1.0,
          color: Colors.black,
        ),
      ),
    );

    Text txt01 = Text(
      'RP',
      style: txt15,
    );

    Column colFirst = Column(
      children: [txt00, sb00, txt01],
    );

    Divider dv01 = const Divider(
      color: Colors.black,
      thickness: 10.0,
      height: 50,
      indent: 10,
      endIndent: 1,
    );

    Padding cont1 = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 2, // Thickness
        height: 35,
        color: Colors.grey,
      ),
    );

    lstWidget.add(dv01);
    lstWidget.add(colFirst);
    //

    for (int i = 0; i < list.length; i++) {
      List<Widget> lstColumn = [];

      Text txt1 = Text(
        list[i].weight.toString(),
        style: txt15,
      );
      lstColumn.add(txt1);
      Divider dv1 = Divider(
        color: Colors.blue,
        height: 1,
        indent: 1,
        endIndent: 1,
      );

      lstColumn.add(sb00);
      Text txt3 = Text(
        list[i].qty.toString(),
        style: txt15,
      );
      lstColumn.add(txt3);
      Column col1 = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: lstColumn,
      );

      lstWidget.add(cont1);
      lstWidget.add(col1);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lstWidget,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }

  @override
  void initState() {
    super.initState();
    row_set_crud.getAll(widget.day.id).then((value) {
      setState(() {
        print(value);
        if (value != null) {
          listRowSet = value;
        }
      });
    });
  }
}
