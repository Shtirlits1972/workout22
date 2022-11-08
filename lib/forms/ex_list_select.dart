import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout1/block/exercise_block.dart';
import 'package:workout1/constants.dart';
import 'package:workout1/crud/exCrud.dart';
import 'package:workout1/model/exercise.dart';

class ExListSelect extends StatefulWidget {
  const ExListSelect({Key? key}) : super(key: key);

  @override
  _ExListSelectState createState() => _ExListSelectState();
}

class _ExListSelectState extends State<ExListSelect> {
  exercise selectEx = exercise.empty();
  int groupValue = 1;
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
                // showEdit = true;
              });
            },
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Add new Exercise',
          )
        ],
      ),
      body: BlocBuilder<DataCubitEx, KeeperEx>(builder: (context, state) {
        return Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  itemCount: context.read<DataCubitEx>().getExercise.length,
                  itemBuilder: (context, index) {
                    return RadioListTile<int>(
                      activeColor: Colors.blueAccent,
                      title: Text(
                        context.read<DataCubitEx>().getExercise[index].NameEx,
                        style: txt15,
                      ),
                      value: context.read<DataCubitEx>().getExercise[index].id,
                      groupValue: groupValue,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          selectEx =
                              context.read<DataCubitEx>().getExercise[index];
                          groupValue = value!;
                        });
                      },
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        print('selectEx = $selectEx');
                        Navigator.pop(context, selectEx);
                      },
                      child: Text(
                        'OK',
                        style: txt15,
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        print('cancel and return');
                        Navigator.pop(context, null);
                      },
                      child: Text(
                        'Cancel',
                        style: txt15,
                      ),
                    ),
                  ),
                ],
              )
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
