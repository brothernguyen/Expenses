import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/completedCardDetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './script.dart';

class Completed extends StatefulWidget {
  const Completed({Key key}) : super(key: key);

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  List<Script> items = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchScripts();
  }

  Future<void> fetchScripts() async {
    setState(() {
      isLoading = true;
    });

    List<Script> itemsFromJson = [];
    final url = Uri.parse(
        'https://flutter-prototype-dcaf5-default-rtdb.firebaseio.com/scripts.json');
    try {
      await http
          .get(url)
          .then((response) => {
                for (final item in jsonDecode(response.body))
                  {itemsFromJson.add(Script.fromJson(item))}
              })
          .then((_) => {
                setState(() {
                  items = itemsFromJson;
                  isLoading = false;
                })
              });
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
          fetchScripts();
        },
        child: Center(child: _buildList(context)),
      ),
    );
  }

  Widget _buildList(context) {
    return isLoading
        ? CupertinoActivityIndicator(
            animating: isLoading,
            radius: 14.0,
            color: Color.fromARGB(255, 79, 81, 84),
          )
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => {onCardTapped(context, items[index])},
                    child: _card(index),
                  ),
                ],
              );
            });
  }

  onCardTapped(context, Script item) {
    if (item.isCompleted) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CompletedCardDetail(item, fetchScripts)),
      );
    }
  }

  Card _card(int index) {
    double elevation = Platform.isAndroid ? 16 : 0;
    bool isCompleted = items[index].isCompleted;
    if (!isCompleted) {
      return Card(
        child: Container(
          height: 0,
          width: 0,
        ),
      );
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: elevation,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
                image: NetworkImage(items[index].img), fit: BoxFit.cover),
          ),
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(12),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items[index].title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          items[index].description,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.white70,
                          ),
                        ),
                      ]),
                ]),
          ),
        ),
      ),
    );
  }
}
