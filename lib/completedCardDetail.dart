import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import './script.dart';

// ignore: must_be_immutable
class CompletedCardDetail extends StatefulWidget {
  Script item;
  VoidCallback refreshCompletedPage;
  CompletedCardDetail(Script item, this.refreshCompletedPage, {Key key})
      : super(key: key) {
    this.item = item;
    this.refreshCompletedPage = refreshCompletedPage;
  }

  @override
  State<CompletedCardDetail> createState() => _CompletedCardDetailState();
}

class _CompletedCardDetailState extends State<CompletedCardDetail> {
  bool isDisplayDialog = true;
  bool isChecked = false;
  List _selected = [];
  Script script;
  bool selectedChoice = true;
  List radioOptions = [];
  final DBRef = FirebaseDatabase.instance.ref();

  void initState() {
    super.initState();
    script = widget.item;
    //Radio button values
    radioOptions = script.questions[4]['options'];
    //Checkbox values
    _selected = script.questions[5]['options'];
  }

  @override
  Widget build(BuildContext context) {
    Script script = widget.item;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(script.title),
            automaticallyImplyLeading: true,
            leading: CupertinoNavigationBarBackButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.playlist_remove),
              color: Colors.blueAccent,
              onPressed: () {
                resetData(script);
              },
            ),
          )
        : AppBar(title: Text(script.title), actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.playlist_remove),
              color: Colors.white,
              onPressed: () {
                resetData(script);
              },
            ),
          ]);

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
      color: Color.fromARGB(255, 247, 246, 243),
      child: Container(
        height: 150,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(script.questions[index]['title']),
            ),
            SizedBox(
              width: 240,
              height: 50,
              child: CupertinoButton(
                // onPressed: () {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => ChewiePlayer()));
                // },
                child: const Text(
                  'Play Video',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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
    String defaultText = script.questions[2]['value'].toString();
    return Card(
      color: Color.fromARGB(255, 247, 246, 243),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(script.questions[index]['title']),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            //color: Color.fromARGB(255, 219, 218, 211),
            child: TextField(
              readOnly: true,
              maxLines: 3,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: defaultText.isEmpty ? 'Enter value' : defaultText),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  // NUMERIC QUESTION
  //==========================================================
  Card numericQuestion(int index) {
    String defaultNumeric = script.questions[3]['value'].toString();
    return Card(
      color: Color.fromARGB(255, 247, 246, 243),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(script.questions[index]['title']),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            //color: Color.fromARGB(255, 219, 218, 211),
            child: TextFormField(
              readOnly: true,
              maxLines: 3,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText:
                    defaultNumeric.isEmpty ? 'Enter answer' : defaultNumeric,
              ),
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
      color: Color.fromARGB(255, 247, 246, 243),
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
                onChanged: null);
          },
        ).toList(),
      );

  // setSelectedChoice(Map<String, dynamic> option, bool value) {
  //   for (int i = 0; i < radioOptions.length; i++) {
  //     radioOptions[i]['selected'] = false;
  //     if (radioOptions[i]['choice'] == option['choice']) {
  //       setState(() {
  //         radioOptions[i]['selected'] = true;
  //       });
  //     }
  //   }
  // }

  //MULTI CHOICE
  //==========================================================
  Card multiChoice(int index) {
    return Card(
      color: Color.fromARGB(255, 247, 246, 243),
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
      rows.add(DataRow(
          cells: [
            DataCell(Text(_selected[index]['option'])),
          ],
          selected: _selected[index]['selected'],
          onSelectChanged: (bool selected) {}));
    }
    return rows;
  }

  //RESET DATA
  //==========================================================
  resetSelectedChoice() {
    for (int i = 0; i < radioOptions.length; i++) {
      radioOptions[i]['selected'] = false;
    }
  }

  resetMultipleChoice() {
    List<Map<String, dynamic>> multipleOptions = [];
    for (int i = 0; i < _selected.length; i++) {
      _selected[i]['selected'] = false;
    }
  }

  void resetData(Script item) async {
    var id = item.id.toString();
    resetSelectedChoice();
    resetMultipleChoice();

    // Video question
    await DBRef.child('scripts/$id/').update({'videoUrl': ""});

    // Text question
    await DBRef.child('scripts/$id/questions/2/').update({'value': ""});

    // Numeric question
    await DBRef.child('scripts/$id/questions/3/').update({'value': ""});

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

    // Script status
    await DBRef.child('scripts/$id/')
        .update({'isCompleted': false})
        .then((_) => widget.refreshCompletedPage())
        .then((_) => Navigator.of(context).pop());
  }
}
