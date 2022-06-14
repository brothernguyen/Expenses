import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/question.dart';
import 'package:flutter_complete_guide/script.dart';
import 'package:firebase_database/firebase_database.dart';

//import './login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CardDetail extends StatefulWidget {
  Script item;
  CardDetail(Script item, {Key key}) : super(key: key) {
    this.item = item;
  }

  @override
  CardDetailState createState() {
    return CardDetailState();
  }
}

class CardDetailState extends State<CardDetail> {
  final DBRef = FirebaseDatabase.instance.ref();
  TextEditingController _controller;
  bool isDisplayDialog = true;
  bool isChecked = false;
  List<bool> _selected = [];
  Script script;
  bool selectedChoice = true;
  List radioOptions = [];

  void initState() {
    super.initState();
    _controller = TextEditingController();
    script = widget.item;
    List options = script.questions[5]['options'];
    _selected = List<bool>.generate(options.length, (int index) => false);

    //Radio button values
    radioOptions = script.questions[4]['options'];
    // for (var item in radioOptions) {
    //   radioValues.add(item['selected']);
    // }
  }

  @override
  Widget build(BuildContext context) {
    Script script = widget.item;
    isDisplayDialog
        ? Future.delayed(Duration.zero, () => displayDialog(context, script))
        : "";
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(script.title),
            trailing: IconButton(
              icon: const Icon(Icons.done_all),
              tooltip: 'Log out',
              onPressed: () {
                updateData(script);
              },
            ),
            automaticallyImplyLeading: true,
            leading: CupertinoNavigationBarBackButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
          )
        : AppBar(
            title: Text(script.title),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.done_all),
                tooltip: 'Log out',
                onPressed: () {
                  updateData(script);
                },
              ),
            ],
          );
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: ListView.builder(
          itemCount: script.questions.length,
          itemBuilder: (context, index) {
            switch (script.questions[index]['type']) {
              case "VIDEO":
                {
                  return videoQuestionCard(index);
                }
              case "TEXT":
                {
                  return textQuestionCard(index);
                }
                break;

              case "NUMERIC":
                {
                  return textQuestionCard(index);
                }

              case "SINGLE_CHOICE":
                {
                  return singleChoice(index);
                }
                break;

              case "MULTIPLE_CHOICE":
                {
                  return multiChoice(index);
                }
                break;

              default:
                {
                  //print("Invalid choice");
                }
                break;
            }
            return Container(
              height: 0,
              width: 0,
            );
          },

          // children: [
          //   textQuestionCard(script),
          //   singleChoice(script),
          //   multiChoice(script),
          // ],
        ),
      ),
    );
  }

  // VIDEO TYPE
  //==========================================================
  Card videoQuestionCard(int index) {
    return Card(
      color: Color.fromARGB(255, 192, 190, 181),
      child: Container(
        height: 150,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(script.questions[index]['title']),
            ),
            SizedBox(
              width: 280,
              height: 50,
              child: CupertinoButton(
                onPressed: () {
                  updateData(script);
                },
                child: const Text(
                  'Start Recording',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(width: 80),
          ],
        ),
      ),
    );
  }

  // TEXT & NUMERIC TYPE
  //==========================================================
  Card textQuestionCard(int index) {
    return Card(
      color: Color.fromARGB(255, 192, 190, 181),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(script.questions[index]['title']),
          ),
          TextFormField(
            maxLines: 3,
            keyboardType:
                index == 3 ? TextInputType.number : TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'Enter answer',
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  setSelectedChoice(Map<String, dynamic> option, bool value) {
    for (int i = 0; i < radioOptions.length; i++) {
      radioOptions[i]['selected'] = false;
      if (radioOptions[i]['choice'] == option['choice']) {
        setState(() {
          radioOptions[i]['selected'] = true;
        });
      }
    }
    // setState(() {
    // });
  }

  // SINGLE CHOICE
  //==========================================================
  Card singleChoice(int index) {
    print(radioOptions);

    return Card(
      color: Color.fromARGB(255, 192, 190, 181),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(script.questions[index]['title']),
          ),
          Column(
            // children: singleChoiceQuestionCard(script),
            children: [buildRadios(radioOptions)],
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget buildRadios(List radioOptions) => Column(
        children: radioOptions.map(
          (option) {
            return RadioListTile<bool>(
              value: true,
              groupValue: option['selected'],
              title: Text(option["choice"]),
              onChanged: (value) =>
                  setState(() => setSelectedChoice(option, value)),
              //onChanged: (value) => print(option),
            );
          },
        ).toList(),
      );

  //MULTI CHOICE
  //==========================================================
  Card multiChoice(int index) {
    return Card(
      color: Color.fromARGB(255, 192, 190, 181),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(script.questions[index]['title']),
          ),
          Column(children: [_createDataTable(index)]),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('All')),
    ];
  }

  DataTable _createDataTable(int index) {
    return DataTable(columns: _createColumns(), rows: _createRows(index));
  }

  List<DataRow> _createRows(int index) {
    List options = script.questions[index]['options'];
    List<DataRow> rows = [];

    for (int index = 0; index < options.length; index++) {
      rows.add(DataRow(
          cells: [
            DataCell(Text(options[index]['option'])),
          ],
          selected: options[index]['selected'],
          onSelectChanged: (bool selected) {
            setState(() {
              _selected[index] = selected;
            });
          }));
    }
    return rows;
  }

  void updateData(Script item) {
    var id = item.id.toString();
    // Convert Dynamic type to String
    // final List<String> updateList =
    //     radioOptions.map((e) => e.toString()).toList();

    // DBRef.child('scripts/$id').update({'title': 'BBBBB'});
    // DBRef.child('scripts/$id/questions/4/').update({'options': updateList});

    // print(map1.runtimeType);
    // print(map1.toString());
  }

  //DIALOG
  //==========================================================
  displayDialog(BuildContext context, Script script) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(script.questions[0]['type']),
          content: Text(script.questions[0]['title']),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      isDisplayDialog = false;
                    });
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
