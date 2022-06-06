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

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Script script = widget.item;
    Future.delayed(Duration.zero, () => showHelpDialog(context, script));
    print(DBRef);
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
    return Scaffold(appBar: appBar, body: Text('dcdcd'));
  }

  // void updateData(Script item) {
  //   var id = item.id.toString();
  //   DBRef.child('scripts/$id').update({'title': 'BBBBB'});
  // }
}

showHelpDialog(BuildContext context, Script script) {
  final abc = script.questions[4]['options'];
  print(abc);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(script.questions[0]['type']),
          content: Text(script.questions[0]['title']),
        );
      });
}
