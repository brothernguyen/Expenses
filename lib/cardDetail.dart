import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/script.dart';
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
  @override
  Widget build(BuildContext context) {
    Script script = widget.item;
    print(script.first_name);
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
    );
  }
}
