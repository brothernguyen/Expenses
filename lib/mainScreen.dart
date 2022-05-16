import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/script.dart';
//import './login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  MainScreenState createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  List<Script> items = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchScripts();
  }

  @override
  void didUpdateWidget(MainScreen oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  void fetchScripts() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
        'https://flutter-prototype-dcaf5-default-rtdb.firebaseio.com/scripts.json');
    try {
      final response = await http.get(url);
      List<Script> itemsFromJson = [];

      for (final item in jsonDecode(response.body)) {
        itemsFromJson.add(Script.fromJson(item));
      }
      setState(() {
        items = itemsFromJson;
        isLoading = false;
      });
    } catch (error) {
      throw (error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Data Question'),
            automaticallyImplyLeading: false,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    CupertinoIcons.power,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
          )
        : AppBar(title: const Text('Data Question'), actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.power_settings_new),
              tooltip: 'Log out',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]);

    return Scaffold(
      appBar: appBar,
      drawer: Container(
          width: MediaQuery.of(context).size.width * 0.9, child: _drawer()),
      body: Center(child: _buildList()),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _bottomBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.file_copy_outlined),
          label: 'Scripts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist_outlined),
          label: 'Completed',
        ),
      ],
      selectedItemColor: Colors.amber[800],
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Image.asset(
              'assets/images/logo-vidlet-butterfly.png',
              scale: 1.2,
            ),
          ),
          ListTile(
            trailing: Switch.adaptive(value: true, onChanged: (value) {}),
            title: Text('WiFi only'),
          ),
          ListTile(
            trailing: Switch.adaptive(value: true, onChanged: (value) {}),
            title: Text('HD Video'),
          ),
          ListTile(
            title: Text('Support'),
          ),
          ListTile(
            title: Text('Private Policy'),
          ),
          ListTile(
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
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
                  // _tile(items[index].title, items[index].subTitle),
                  _card(index),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                    color: Colors.blue,
                  ),
                ],
              );
            });
  }

  Card _card(int index) {
    var imgUrl = "https://picsum.photos/200/300?random=${index.toString()}";
    return Card(
        elevation: 6,
        margin: const EdgeInsets.all(12),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(imgUrl), fit: BoxFit.cover)),
                child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(12),
                    child: Text(items[index].title,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70))))));
  }

  // ListTile _tile(String title, String subtitle) {
  //   return ListTile(
  //     title: Text(title,
  //         style: const TextStyle(
  //             fontWeight: FontWeight.w500,
  //             fontSize: 20,
  //             color: Colors.black87)),
  //     subtitle: Text(subtitle),
  //     trailing: Icon(Icons.arrow_forward),
  //   );
  // }
}
