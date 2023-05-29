import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail-screen';
  const DetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Transaction;
    var format = NumberFormat.simpleCurrency(locale: 'en_IN');
    TextStyle style =
        const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.title),
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Text(
                arguments.spendType,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.secondary),
          height: 500,
          width: 500,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Title: ", style: style),
                  Text(arguments.title, style: style)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Amount: ",
                    style: style,
                  ),
                  FittedBox(
                    child: Text(
                      "${format.currencySymbol} ${arguments.amount.toString()}",
                      style: style,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Date: ", style: style),
                  Text(DateFormat.yMMMd().format(arguments.date), style: style)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Category: ", style: style),
                  Text(arguments.category, style: style),
                ],
              ),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Transaction type: ", style: style),
                    Text(arguments.spendType, style: style),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
