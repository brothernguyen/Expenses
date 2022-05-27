import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/login.dart';
import 'package:flutter_complete_guide/script.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './cardDetail.dart';
import './pickImage.dart';

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
  int _selectedIndex = 0;

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
      return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text(
                  "An error occurred",
                ),
                content: Text(error.toString()),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => {Navigator.of(ctx).pop()},
                      child: Text('Okey'))
                ],
              ));
    }
  }

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle =
        _selectedIndex == 0 ? 'Data Question' : 'Choose an image';
    final PreferredSizeWidget appBar =
        AppBar(title: Text(appBarTitle), actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.power_settings_new),
        tooltip: 'Log out',
        onPressed: () {
          _signOut(context);
        },
      ),
    ]);

    return Scaffold(
      appBar: appBar,
      drawer: Container(
          width: MediaQuery.of(context).size.width * 0.9, child: _drawer()),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
          fetchScripts();
        },
        //child: Center(child: _buildList(context)),
        child: _tabBarItems(context, _selectedIndex),
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _tabBarItems(BuildContext context, int _selectedIndex) {
    List<Widget> widgetOptions = <Widget>[
      Center(child: _buildList(context)),
      PickImage(),
    ];
    return widgetOptions.elementAt(_selectedIndex);
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
      currentIndex: _selectedIndex,
      onTap: onBottomBarTapped,
    );
  }

  void onBottomBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            onTap: () async {
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
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
    if (!item.isPublished) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CardDetail()),
      );
    }
  }

  Card _card(int index) {
    //var imgUrl = "https://picsum.photos/120/250?random=${index.toString()}";
    double elevation = Platform.isAndroid ? 16 : 0;
    String isPublished = items[index].isPublished ? 'Published' : 'Unpublished';
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        isPublished,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          items[index].title,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          "${items[index].first_name} ${items[index].last_name}",
                          style: TextStyle(
                            fontSize: 18,
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
