import 'package:flutter/material.dart';
import 'package:planner_app/models/transaction.dart';
import 'package:planner_app/widgets/edit_item.dart';
import '../provider/expenses.dart';
import 'package:provider/provider.dart';

class EditList extends StatefulWidget {
  @override
  State<EditList> createState() => _EditListState();
}

class _EditListState extends State<EditList> {
  Widget returnLayOut(BuildContext context) {
    return Center(
      child: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('No tranctions added yet!',
                style: Theme.of(context).textTheme.titleMedium),
            SizedBox(
              height: 10,
            ),
            Container(
                height: constraints.maxHeight * 0.6,
                child: Image.asset('assets/images/waiting.png',
                    fit: BoxFit.cover)),
          ],
        );
      }),
    );
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
                          itemCount: expenses.items.length,
                          itemBuilder: (ctx, i) {
                            return EditItem(
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
