import 'package:flutter/material.dart';
import 'package:workout1/constants.dart';
import 'package:workout1/model/row_set.dart';
import 'package:workout1/model/set_ex.dart';

class SetExAdd extends StatefulWidget {
  SetExAdd({Key? key}) : super(key: key);
  // RowSet rowSet;
  //String strName;
  @override
  _SetExAddState createState() => _SetExAddState();
}

class _SetExAddState extends State<SetExAdd> {
  TextEditingController weightContr = TextEditingController(text: '0');
  TextEditingController qtyContr = TextEditingController(text: '1');
  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    //Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    //final arguments = ModalRoute.of(context)?.settings.arguments as String?;
    //final rs = arguments['rowSet1'];
    int y = 0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('widget.strName'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        'weight',
                        style: txt30,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: weightContr,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        'qty',
                        style: txt30,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onSubmitted: ((value) {
                          print('submit weight');
                        }),
                        style: txt15,
                        controller: qtyContr,
                        decoration: const InputDecoration(
                          hintText: 'Enter name of exercise',
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: SizedBox()),
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
                    onPressed: (() {
                      print('OK');
                      double dubWeight = 0;
                      int qty = 1;

                      try {
                        dubWeight = double.parse(weightContr.text);
                        qty = int.parse(qtyContr.text);
                      } catch (e) {
                        print(e);
                      }

                      SetEx setEx = SetEx(0, 0, dubWeight, qty);
                      Navigator.pop(context, setEx);
                    }),
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
                    onPressed: (() {
                      print('Cancel');
                      Navigator.pop(context, null);
                    }),
                    child: Text(
                      'Cancel',
                      style: txt15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
              width: 250,
            )
          ],
        ),
      ),
    );
  }
}
