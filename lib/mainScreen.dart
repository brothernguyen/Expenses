import 'package:flutter/material.dart';
import './login.dart';
import './script.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Question'),
      ),
      body: Center(child: _buildList()
          // child: ElevatedButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   child: const Text('Log out'),
          // ),
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
          )),
      subtitle: Text(subtitle),
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
