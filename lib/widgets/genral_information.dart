import 'package:flutter/material.dart';
import 'package:planner_app/provider/expenses.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class GeneralInformation extends StatefulWidget {
  @override
  State<GeneralInformation> createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {
  List<Transaction> recentTransactions = [];

  @override
  Widget build(BuildContext context) {
    var format = NumberFormat.simpleCurrency(locale: 'en_IN');
    return FutureBuilder(
      future: Provider.of<Expenses>(context, listen: false)
          .fetchAndSetTransaction(),
      builder: (ctx, snapShot) =>
          Consumer<Expenses>(builder: (ctx, expenses, ch) {
        recentTransactions = expenses.items;
        double totalExpenses = 0;
        double totalIncome = 0;
        for (int i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].spendType.toLowerCase() == "expense") {
            if (recentTransactions[i].date.month == DateTime.now().month)
              totalExpenses += (recentTransactions[i].amount * -1);
          } else {
            if (recentTransactions[i].date.month == DateTime.now().month)
              totalIncome += recentTransactions[i].amount;
          }
        }

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(147, 118, 224, 1),
                Color.fromRGBO(232, 147, 207, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.1,
                0.9,
              ],
            ),
          ),
          child: Card(
            elevation: 6,
            margin: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Expenses:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${format.currencySymbol}  ${totalExpenses}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Income:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${format.currencySymbol}  ${totalIncome}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Balance:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      if ((totalIncome - (totalExpenses * -1)) > 0)
                        Text(
                          "${format.currencySymbol}  ${totalIncome - (totalExpenses * -1)}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      if ((totalIncome - (totalExpenses * -1)) <= 0)
                        Text(
                          "${format.currencySymbol}  ${totalIncome - (totalExpenses * -1)}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
