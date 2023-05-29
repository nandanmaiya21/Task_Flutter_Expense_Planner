import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final String spendType;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
    @required this.category,
    @required this.spendType,
  });
}
