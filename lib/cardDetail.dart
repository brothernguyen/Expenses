import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  String selectedChoice = "";
  bool isDisplayDialog = true;
  bool isChecked = false;
  List<bool> _selected = [];

  void initState() {
    super.initState();
    _controller = TextEditingController();
    Script script = widget.item;
    List options = script.questions[5]['options'];
    _selected = List<bool>.generate(options.length, (int index) => false);
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
            automaticallyImplyLeading: true,
            leading: CupertinoNavigationBarBackButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
          )
        : AppBar(
            title: Text(script.title),
          );
    return Scaffold(
      appBar: appBar,
      body: Center(
          // child: multiChoice(script),
          child: ListView(
        children: [
          textQuestionCard(script),
          singleChoice(script),
          multiChoice(script),
        ],
      )),
    );
  }

  // TEXT & NUMERIC TYPE
  Card textQuestionCard(Script script) {
    return Card(
      color: Color.fromARGB(255, 192, 190, 181),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(script.questions[2]['title']),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter answer',
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  setSelectedChoice(String choice) {
    setState(() {
      selectedChoice = choice;
    });
  }

  // SINGLE CHOICE
  List<Widget> choiceQuestionCard(Script script) {
    //double elevation = Platform.isAndroid ? 16 : 0;
    List options = script.questions[4]['options'];
    List<Widget> widgets = [];
    for (var option in options) {
      widgets.add(
        RadioListTile(
          value: option,
          groupValue: selectedChoice,
          title: Text(option),
          onChanged: (val) {
            setSelectedChoice(val);
          },
          selected: selectedChoice == option,
          activeColor: Colors.green,
        ),
      );
    }
    return widgets;
  }

  Card singleChoice(Script script) {
    //double elevation = Platform.isAndroid ? 16 : 0;
    return Card(
      color: Color.fromARGB(255, 192, 190, 181),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(script.questions[4]['title']),
          ),
          Column(
            children: choiceQuestionCard(script),
          ),
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

  DataTable _createDataTable(Script script) {
    return DataTable(columns: _createColumns(), rows: _createRows(script));
  }

  List<DataRow> _createRows(Script script) {
    List options = script.questions[5]['options'];
    List<DataRow> rows = [];

    for (int index = 0; index < options.length; index++) {
      rows.add(DataRow(
          cells: [
            DataCell(Text('ASD')),
          ],
          selected: _selected[index],
          onSelectChanged: (bool selected) {
            setState(() {
              _selected[index] = selected;
            });
          }));
    }
    return rows;
  }

  Card multiChoice(Script script) {
    return Card(
      color: Color.fromARGB(255, 192, 190, 181),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(script.questions[5]['title']),
          ),
          Column(children: [_createDataTable(script)]),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  // void updateData(Script item) {
  //   var id = item.id.toString();
  //   DBRef.child('scripts/$id').update({'title': 'BBBBB'});
  // }

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
