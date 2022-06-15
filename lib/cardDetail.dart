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
  final textController = TextEditingController();
  final numericController = TextEditingController();

  bool isDisplayDialog = true;
  bool isChecked = false;
  List _selected = [];
  Script script;
  bool selectedChoice = true;
  List radioOptions = [];

  void initState() {
    super.initState();
    script = widget.item;
    //Radio button values
    radioOptions = script.questions[4]['options'];
    //Checkbox values
    _selected = script.questions[5]['options'];
  }

  @override
  void dispose() {
    textController.dispose();
    numericController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(textController.text.trim());
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
                  return textQuestion(index);
                }
                break;

              case "NUMERIC":
                {
                  return numericQuestion(index);
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
                // onPressed: () {
                //   updateData(script);
                // },
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

  // TEXT QUESTION
  //==========================================================
  Card textQuestion(int index) {
    return Card(
      color: Color.fromARGB(255, 192, 190, 181),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(script.questions[index]['title']),
          ),
          TextFormField(
            controller: textController,
            maxLines: 3,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'Enter answer',
            ),
            onChanged: (value) {
              setState(() {
                textController.text = value.toString();
              });
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  // NUMERIC QUESTION
  //==========================================================
  Card numericQuestion(int index) {
    return Card(
      color: Color.fromARGB(255, 192, 190, 181),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(script.questions[index]['title']),
          ),
          TextFormField(
            controller: numericController,
            maxLines: 3,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter answer',
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  // SINGLE CHOICE
  //==========================================================
  Card singleChoice(int index) {
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

  setSelectedChoice(Map<String, dynamic> option, bool value) {
    for (int i = 0; i < radioOptions.length; i++) {
      radioOptions[i]['selected'] = false;
      if (radioOptions[i]['choice'] == option['choice']) {
        setState(() {
          radioOptions[i]['selected'] = true;
        });
      }
    }
  }

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

  List<DataRow> _createRows(int i) {
    List<DataRow> rows = [];
    for (int index = 0; index < _selected.length; index++) {
      //print(_selected[index]['selected']);
      rows.add(DataRow(
          cells: [
            DataCell(Text(_selected[index]['option'])),
          ],
          selected: _selected[index]['selected'],
          onSelectChanged: (bool selected) {
            setState(() {
              _selected[index]['selected'] = selected;
            });
          }));
    }
    return rows;
  }

  void updateData(Script item) async {
    var id = item.id.toString();

    // Text question
    await DBRef.child('scripts/$id/questions/2/')
        .update({'value': textController.text});

    // Single choi question
    List<Map<String, dynamic>> singleOptions = [];
    for (var option in radioOptions) {
      singleOptions.add(option);
    }
    await DBRef.child('scripts/$id/questions/4/')
        .update({'options': singleOptions});

    // Multiple choice question
    List<Map<String, dynamic>> multipleOptions = [];
    for (var option in _selected) {
      multipleOptions.add(option);
    }
    await DBRef.child('scripts/$id/questions/5/')
        .update({'options': multipleOptions});

    print(multipleOptions);
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
