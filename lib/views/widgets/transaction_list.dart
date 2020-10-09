import 'package:flutter/material.dart';

import 'transaction_item.dart';
import '../../models/transaction.dart';

class TransactionList extends StatelessWidget {
  // List of submitted transactions.
  final List<Transaction> transactions;
  // Method used to handle transaction deletion.
  final Function deleteTx;

  TransactionList({
    @required this.transactions,
    @required this.deleteTx,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(
                  transaction: transactions[index], deleteTx: deleteTx);
            },
            itemCount: transactions.length,
          );
  }
}
