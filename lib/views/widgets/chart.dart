import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';
import '../../models/transaction.dart';

class Chart extends StatelessWidget {
  // List of recent transactions.
  final List<Transaction> recentTransactions;

  Chart({this.recentTransactions});

  // Get a list of grouped transaction values.
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      // Day of week.
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      // Total transaction spending.
      var totalSum = 0.0;

      for (var tx in recentTransactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  // Get the spending total.
  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'],
                spendingAmount: data['amount'],
                spendingPctOfTotal: totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
