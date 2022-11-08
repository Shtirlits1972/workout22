import 'package:flutter/material.dart';
import 'package:workout1/constants.dart';
import 'package:workout1/crud/row_set_crud.dart';
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
                                style: txt15,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              print('Add one time');
                              RowSet rowSet1 = listRowSet[index];
                              Navigator.pushNamed<SetEx>(context, '/SetExAdd')
                                  .then((value) {
                                if (value != null) {
                                  value.RowId = listRowSet[index].id;

                                  print(value);
                                }
                              });

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => SetExAdd()),
                              // ).then((value) {
                              //   print(value);
                              // });

                              // MaterialPageRoute(
                              //     builder: (context) => SetExAdd(

                              //         ));

                              //    .then((value) {
                              //   print('value = $value');
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
                                        listRowSet.removeAt(index);
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

  @override
  void initState() {
    super.initState();
    row_set_crud.getAll(widget.day.id).then((value) {
      setState(() {
        listRowSet = value;
      });
    });
  }
}
