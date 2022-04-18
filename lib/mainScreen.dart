import 'package:flutter/material.dart';
import './login.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

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
    return ListView(
      children: [
        _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
        const Divider(
          thickness: 2.0,
        ),
        _tile('The Castro Theater', '429 Castro St', Icons.theaters),
        const Divider(
          thickness: 2.0,
        ),
        _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
        const Divider(
          thickness: 2.0,
        ),
        _tile('Roxie Theater', '3117 16th St', Icons.theaters),
        const Divider(
          thickness: 2.0,
        ),
        _tile('United Artists Stonestown Twin', '501 Buckingham Way',
            Icons.theaters),
        const Divider(
          thickness: 2.0,
        ),
        _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
        const Divider(
          thickness: 2.0,
        ),
        _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
        const Divider(
          thickness: 2.0,
        ),
        _tile('Emmy\'s Restaurant', '1923 Ocean Ave', Icons.restaurant),
        const Divider(
          thickness: 2.0,
        ),
        _tile('Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
        const Divider(
          thickness: 2.0,
        ),
        _tile('La Ciccia', '291 30th St', Icons.restaurant),
        const Divider(
          thickness: 2.0,
        ),
        _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
        const Divider(
          thickness: 2.0,
        ),
        _tile('The Castro Theater', '429 Castro St', Icons.theaters),
        const Divider(
          thickness: 2.0,
        ),
        _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
        const Divider(
          thickness: 2.0,
        ),
        _tile('Roxie Theater', '3117 16th St', Icons.theaters),
        const Divider(
          thickness: 2.0,
        ),
        _tile('United Artists Stonestown Twin', '501 Buckingham Way',
            Icons.theaters),
      ],
    );
  }

  ListTile _tile(String title, String subtitle, IconData icon) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(subtitle),
      leading: Icon(
        icon,
        color: Colors.blue[500],
      ),
    );
  }
}
