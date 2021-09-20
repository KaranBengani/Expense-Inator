import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UserInput extends StatefulWidget {
  final Function AddTransaction;

  UserInput(this.AddTransaction);

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();

  DateTime edateTime = DateTime.now();
  int count = 0;

  void tx() {
    final enteredTitle = titlecontroller.text;
    final enteredAmount = double.parse(amountcontroller.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.AddTransaction(
      enteredTitle,
      enteredAmount,
      edateTime,
    );
    Navigator.of(context).pop();
  }

  void setdate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        edateTime = value;
        count = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title Of Expense"),
              controller: titlecontroller,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount Spent"),
              controller: amountcontroller,
              keyboardType: TextInputType.number,
              onSubmitted: (val) => tx(),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  count != 1
                      ? "No date chosen!"
                      : "Date chosen: ${DateFormat.yMEd().format(edateTime)}",
                ),
                IconButton(
                  onPressed: setdate,
                  icon: Icon(
                    Icons.calendar_today_sharp,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
            RaisedButton(
                child: Text(
                  "Add Record",
                ),
                onPressed: tx,
                color: Theme.of(context).accentColor),
          ],
        ),
      ),
    );
  }
}
