import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';
import '../widgets/charbar.dart';

class ExpenseChart extends StatelessWidget {
  final List<Transaction> transactionList;

  List get chartDetails {
    return List.generate(7, (index) {
      final day = DateTime.now().subtract(Duration(days: index));
      var total = 0.0;
      for (var i = 0; i < transactionList.length; i++) {
        if (transactionList[i].date.day == day.day &&
            transactionList[i].date.month == day.month &&
            transactionList[i].date.year == day.year) {
          total += transactionList[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(day).substring(0, 1),
        "amount": total
      };
    });
  }

  // double get totalSpending {
  //   return chartDetails.fold(0.0, (sum, e) => sum + e["amount"]);
  // }
  double totalSpending = 0.0;

  ExpenseChart(this.transactionList);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: chartDetails.map((e) {
              totalSpending += e["amount"];

              return Flexible(
                fit: FlexFit.tight,
                child: BarChart(e["day"], e["amount"],
                    totalSpending == 0.0 ? 0.0 : (e["amount"] / totalSpending)),
              );
            }).toList(),
          ),
        ),
        elevation: 5,
        margin: EdgeInsets.all(20),
      ),
    );
  }
}
