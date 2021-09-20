import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/models/transactions.dart';

class TranCard extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delete;

  TranCard(this.transactions, this.delete);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "No Expenses recorded",
                  style: Theme.of(context).textTheme.title,
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                  height: 200,
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, i) {
                return Card(
                  elevation: 5,
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(12),
                        child: FittedBox(
                          child: Text(
                            "\₹ ${transactions[i].amount.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            transactions[i].title,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            DateFormat.yMEd().format(transactions[i].date),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        flex: 3,
                        child: IconButton(
                            onPressed: () => delete(transactions[i].id),
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).accentColor,
                            )),
                      )
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
    );
  }
}
