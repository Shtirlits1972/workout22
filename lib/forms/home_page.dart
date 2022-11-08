import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout1/block/trayn_day_block.dart';
import 'package:workout1/constants.dart';
import 'package:workout1/crud/train_day_crud.dart';
import 'package:workout1/forms/trainDayView.dart';
import 'package:workout1/model/trayn_day.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisible = false;
  DateTime dataTrainDay = DateTime.now().add(Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    String strTraynDay = '';
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      print(index);

      if (index == 0) {
        //  Navigator.pushNamed(context, '/');
      } else if (index == 1) {
        Navigator.pushNamed(context, '/ExList');
      }

      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My workouts'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isVisible = true;
              });
            },
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Add new Train',
          )
        ],
      ),
      body:
          BlocBuilder<DataCubitDays, KeeperTraynDay>(builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: isVisible,
                child: Column(
                  children: [
                    DateTimePicker(
                        type: DateTimePickerType.dateTime,
                        dateMask: 'dd MM yyyy HH:mm',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2020, 1, 1),
                        lastDate: DateTime(2030, 12, 31),
                        icon: const Icon(Icons.event),
                        dateLabelText: 'Date',
                        timeLabelText: "Hour",
                        onChanged: (val) {
                          try {
                            setState(() {
                              strTraynDay = val;
                              isVisible = false;
                              print(val);
                              DateTime? dt1 = DateTime.tryParse(val);

                              if (dt1 != null) {
                                print('dt1 = $dt1');
                                train_day_crud.add(dt1).then(
                                  (value) {
                                    print('value: $value');

                                    setState(() {
                                      state.listDays.add(value!);
                                    });
                                  },
                                );
                              } else {
                                print('data is null');
                              }
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            strTraynDay = val!;
                          });

                          print('Saved: $val');
                        }),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  itemCount: context.read<DataCubitDays>().getExercise.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              train_day d = context
                                  .read<DataCubitDays>()
                                  .getExercise[index];
                              int y = 0;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TrainDayView(day: d)),
                              );
                            },
                            child: Text(
                              dataFormat.format(context
                                  .read<DataCubitDays>()
                                  .getExercise[index]
                                  .data),
                              style: txt15,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Warning!'),
                                  content: const Text('Do you want to delete?'),
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
                                  train_day_crud
                                      .del(context
                                          .read<DataCubitDays>()
                                          .getExercise[index]
                                          .id)
                                      .then((value) {
                                    setState(() {
                                      context.read<DataCubitDays>().del(context
                                          .read<DataCubitDays>()
                                          .getExercise[index]
                                          .id);
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
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Exercis',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void initState() {
    train_day_crud.getAll().then((value) {
      setState(() {
        context.read<DataCubitDays>().setExercise(value);
      });
    });
    super.initState();
  }
}
