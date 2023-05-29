import 'dart:io';
import 'package:flutter/material.dart';
import 'package:planner_app/widgets/new_transaction.dart';

import '../helper/db_helper.dart';
import '../models/transaction.dart';

class Expenses extends ChangeNotifier {
  List<Transaction> _item = [];

  List<Transaction> get items {
    return [..._item];
  }

  void addTransaction(
      {String title,
      double amount,
      DateTime date,
      String category,
      String spendType}) async {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
      category: category,
      spendType: spendType,
    );

    _item.add(newTransaction);
    notifyListeners();
    DBHelper.insert('expenses', {
      'id': newTransaction.id,
      'title': newTransaction.title,
      'amount': newTransaction.amount,
      'date': newTransaction.date.toString(),
      'category': newTransaction.category,
      'spendtype': newTransaction.spendType,
    });
  }

  Future<void> fetchAndSetTransaction() async {
    final dataList = await DBHelper.getData('expenses');
    //print(dataList);
    _item = dataList
        .map((item) => Transaction(
            id: item['id'],
            title: item['title'],
            amount: item['amount'],
            date: DateTime.parse(item['date']),
            category: item['category'],
            spendType: item['spendtype']))
        .toList();
    notifyListeners();
  }

  Future<void> deleteTransaction(String id) async {
    _item.removeWhere((tx) => tx.id == id);
    DBHelper.delete('expenses', id);
    notifyListeners();
  }

  Future<void> updateTransaction({
    String id,
    String title,
    double amount,
    DateTime date,
    String category,
    String spendtype,
  }) async {
    _item[_item.indexWhere((tx) => tx.id == id)] = Transaction(
        id: id,
        title: title,
        amount: amount,
        date: date,
        category: category,
        spendType: spendtype);
    notifyListeners();
    DBHelper.update(
        'expenses', title, amount, date.toString(), category, spendtype, id);
  }
}
