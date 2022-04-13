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
    print('Input!!!');
  }

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
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'PIN'),
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
                      onPressed: () {},
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
                  ]),
            ),
          ),
          // Column(
          //   children: transaction.map((tx) {
          //     return Card(
          //       child: Row(
          //         children: <Widget>[
          //           Container(
          //             margin: EdgeInsets.symmetric(
          //               vertical: 10,
          //               horizontal: 15,
          //             ),
          //             decoration: BoxDecoration(
          //               border: Border.all(color: Colors.black, width: 2),
          //             ),
          //             padding: EdgeInsets.all(10),
          //             child: Text(
          //               '\$${tx.amount.toString()}',
          //               style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 20,
          //                 color: Colors.purple,
          //               ),
          //             ),
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //               Text(
          //                 tx.title,
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               Text(
          //                 DateFormat().format(tx.date),
          //                 style: TextStyle(
          //                   color: Colors.grey,
          //                 ),
          //               )
          //             ],
          //           ),
          //         ],
          //       ),
          //     );
          //   }).toList(),
          // ),
        ],
      ),
    );
  }
}
