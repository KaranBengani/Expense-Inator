import 'package:flutter/material.dart';

import './models/transactions.dart';
import './widgets/userinput.dart';
import './widgets/tranCard.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _userInputPopup(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return UserInput(_SetTran);
        });
  }

  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTrans {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _SetTran(String newTitle, double newAmount, DateTime newdate) {
    final newTran = Transaction(
      title: newTitle,
      amount: newAmount,
      date: newdate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _transactions.add(newTran);
    });
  }

  void delTran(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {

      final appbar = AppBar(
      title: Text("Expense-Inator"),
      actions: [
        Builder(
          builder: (context) => IconButton(
            onPressed: () => _userInputPopup(context),
            icon: Icon(
              Icons.upload_file_sharp,
            ),
          ),
        ),
      ],
    );

    return MaterialApp(
      home: Scaffold(
        appBar: appbar,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.4,
                child: ExpenseChart(_recentTrans),
              ),
              Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.6,
                child: TranCard(_transactions, delTran),
              ),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => _userInputPopup(context),
            child: Icon(Icons.upload_file_sharp),
          ),
        ),
      ),
       theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.teal,
        fontFamily: "Opensans",
        textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
              fontFamily: "Opensans",
              fontSize: 19,
              fontWeight: FontWeight.w700,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: "Opensans",
                    fontSize: 21,
                    fontWeight: FontWeight.w700),
              ),
        ),
      ),
    );
  }
}
