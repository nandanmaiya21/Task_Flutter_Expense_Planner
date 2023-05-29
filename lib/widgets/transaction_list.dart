import 'package:flutter/material.dart';
import 'package:planner_app/widgets/transaction_item.dart';
import '../models/transaction.dart';
import '../provider/expenses.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatefulWidget {
  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  Widget returnLayOut(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Text('No tranctions added yet!',
              style: Theme.of(context).textTheme.titleMedium),
          SizedBox(
            height: 10,
          ),
          Container(
              height: constraints.maxHeight * 0.6,
              child:
                  Image.asset('assets/images/waiting.png', fit: BoxFit.cover)),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Expenses>(context, listen: false)
            .fetchAndSetTransaction(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? returnLayOut(context)
                : Consumer<Expenses>(
                    child: returnLayOut(context),
                    builder: (ctx, expenses, ch) {
                      if (expenses.items.isEmpty) return returnLayOut(context);
                      List<Transaction> tx = expenses.items;
                      tx.sort((a, b) {
                        return a.date.compareTo(b.date);
                      });
                      tx = tx.reversed.toList();
                      return ListView.builder(
                          itemCount: tx.length > 4 ? 4 : tx.length,
                          itemBuilder: (ctx, i) {
                            return TransactionItem(
                              id: tx[i].id,
                              title: tx[i].title,
                              amount: tx[i].amount,
                              date: tx[i].date,
                              category: tx[i].category,
                              spendType: tx[i].spendType,
                            );
                          });
                    }));
  }
}
