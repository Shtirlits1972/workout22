import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout1/block/exercise_block.dart';
import 'package:workout1/constants.dart';
import 'package:workout1/crud/exCrud.dart';
import 'package:workout1/model/exercise.dart';

class ExList extends StatefulWidget {
  const ExList({Key? key}) : super(key: key);

  @override
  _ExListState createState() => _ExListState();
}

class _ExListState extends State<ExList> {
  bool showEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise list'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                showEdit = true;
              });
              //await _selectDate(context);
              // Navigator.pushNamed(context, '/ExList');
            },
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Add new Exercise',
          )
        ],
      ),
      body: BlocBuilder<DataCubitEx, KeeperEx>(builder: (context, state) {
        TextEditingController controller = TextEditingController();

        return Center(
          child: Column(
            children: [
              Visibility(
                  visible: showEdit,
                  child: TextField(
                    onSubmitted: (value) {
                      exCrud.add(controller.text).then((value) {
                        int y = 0;
                        if (value.id > 0) {
                          setState(() {
                            state.listEx.add(value);
                            showEdit = false;
                          });
                        }
                      });
                    },
                    controller: controller,
                    readOnly: false,
                    style: txt15,
                    decoration: const InputDecoration(
                      hintText: 'Enter name of exercise',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3),
                      ),
                    ),
                  )),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  itemCount: context.read<DataCubitEx>().getExercise.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            context
                                .read<DataCubitEx>()
                                .getExercise[index]
                                .NameEx,
                            style: txt15,
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
                                  exCrud
                                      .del(context
                                          .read<DataCubitEx>()
                                          .getExercise[index]
                                          .id)
                                      .then((value) {
                                    setState(() {
                                      context.read<DataCubitEx>().del(context
                                          .read<DataCubitEx>()
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
    );
  }

  @override
  void initState() {
    super.initState();
    exCrud.getAll().then((value) {
      setState(() {
        context.read<DataCubitEx>().setExercise(value);
      });
    });
  }
}
