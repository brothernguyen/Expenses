import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import './login.dart';
import './videoQuestion.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({Key key}) : super(key: key);

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
    final videos = VideoQuestion().videoQuestions;
    return ListView.builder(
        itemCount: videos.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              _tile(videos[index].title, videos[index].subTitle),
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

  ListTile _tile(String title, String subtitle) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.black87)),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.arrow_forward),
    );
  }
}
