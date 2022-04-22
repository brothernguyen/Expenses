import 'package:flutter/material.dart';
//import './login.dart';
import './script.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Question'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.power_settings_new),
          tooltip: 'Log out',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ]),
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
    return ListView.builder(
        itemCount: scripts.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              _tile(scripts[index].title, scripts[index].subTitle),
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

  List<Script> scripts = [
    Script(
      id: '1',
      title: 'CineArts at the Empire',
      subTitle: '85 W Portal Ave',
    ),
    Script(
      id: '2',
      title: 'The Castro Theater',
      subTitle: '429 Castro St',
    ),
    Script(
      id: '3',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '4',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '5',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '6',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '7',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '8',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '9',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '10',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '11',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '12',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '13',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '14',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '15',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '16',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '17',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '18',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '19',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
    Script(
      id: '20',
      title: 'Alamo Drafthouse Cinema',
      subTitle: '2550 Mission St',
    ),
  ];
}
