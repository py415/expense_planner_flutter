import 'package:flutter/foundation.dart';

// Blueprint for transaction.
class Transaction {
  // Identification used to locate transactions.
  final String id;
  // Name of transaction.
  final String title;
  // Cost of transaction.
  final double amount;
  // Date in which transaction occurred.
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
