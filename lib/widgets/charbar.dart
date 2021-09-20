import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final String label;
  final double amount;
  final double colorPercent;

  BarChart(this.label, this.amount, this.colorPercent);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            "\₹ ${amount.toStringAsFixed(0)}",
          ),
        ),
        SizedBox(height: 6),
        Container(
          height: 80,
          width: 17,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(7)),
              ),
              FractionallySizedBox(
                heightFactor: colorPercent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(label),
      ],
    );
  }
}
