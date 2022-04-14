import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/transaction.dart';
import 'package:intl/intl.dart';

import './transaction.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transaction = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.85,
      date: DateTime.now(),
    ),
  ];

  void handleInput() {
    print(emailController.text);
  }

  final emailController = TextEditingController();
  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'vidlet',
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            //elevation: 20,
            borderOnForeground: false,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Email'),
                      controller: emailController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'PIN'),
                      controller: pinController,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        primary: Colors.deepOrange,
                      ),
                      onPressed: () {
                        handleInput();
                      },
                      child: const Text('LOG IN'),
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        primary: Color(0xFF660033),
                      ),
                      onPressed: () {},
                      child: const Text('JOIN OURS EXPERTS'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          padding: EdgeInsets.all(2),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                            onPressed: () {},
                            child: const Text('Help'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          padding: EdgeInsets.all(2),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                            onPressed: () {},
                            child: const Text('Forgot PIN'),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          //Column(
        ],
      ),
    );
  }
}
