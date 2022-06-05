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

  @override
  Widget build(BuildContext context) {
    Script script = widget.item;
    print(DBRef);
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Question Detail'),
            automaticallyImplyLeading: true,
            leading: CupertinoNavigationBarBackButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
          )
        : AppBar(
            title: const Text('Question Detail'),
          );
    return Scaffold(
      appBar: appBar,
      body: ElevatedButton(
        child: Text('Update'),
        onPressed: () {
          updateData(script);
        },
      ),
    );
  }

  void updateData(Script item) {
    var id = item.id.toString();
    DBRef.child('scripts/$id').update({'title': 'BBBBB'});
  }
}
