import 'package:flutter/material.dart';
import 'package:planner_app/Screen/detail_screen.dart';
import 'package:planner_app/models/transaction.dart';
import 'package:planner_app/provider/expenses.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Summary extends StatefulWidget {
  static const routeName = "/summary";
  const Summary({Key key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    var format = NumberFormat.simpleCurrency(locale: 'en_IN');
    List<Transaction> tx = Provider.of<Expenses>(context).items;
    List<Transaction> salary = [];
    List<Transaction> gifts = [];
    List<Transaction> rent = [];
    List<Transaction> food = [];
    List<Transaction> transport = [];
    List<Transaction> others = [];
    DateTime now = DateTime.now();

    double totalSalary = 0;
    double totalGifts = 0;
    double totalRent = 0;
    double totalFood = 0;
    double totalTransport = 0;
    double totalOthers = 0;

    for (int i = 0; i < tx.length; i++) {
      if (tx[i].category.toLowerCase() == "salary" &&
          now.month == tx[i].date.month) {
        salary.add(tx[i]);
        totalSalary += tx[i].amount;
      } else if (tx[i].category.toLowerCase() == "gifts" &&
          now.month == tx[i].date.month) {
        gifts.add(tx[i]);
        totalGifts += tx[i].amount;
      } else if (tx[i].category.toLowerCase() == "rent" &&
          now.month == tx[i].date.month) {
        rent.add(tx[i]);
        totalRent += tx[i].amount;
      } else if (tx[i].category.toLowerCase() == "food" &&
          now.month == tx[i].date.month) {
        food.add(tx[i]);
        totalFood += tx[i].amount;
      } else if (tx[i].category.toLowerCase() == "transport" &&
          now.month == tx[i].date.month) {
        transport.add(tx[i]);
        totalTransport += tx[i].amount;
      } else if (tx[i].category.toLowerCase() == "others" &&
          now.month == tx[i].date.month) {
        others.add(tx[i]);
        totalOthers += tx[i].amount;
      }
    }

    List<Widget> list = [];

    void addHeading(String heading, double total) {
      list.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${heading}",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${format.currencySymbol} ${total}",
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }

    void addToList(List<Transaction> t) {
      TextStyle colorWhite = const TextStyle(color: Colors.white);
      for (int i = 0; i < t.length; i++) {
        list.add(
          InkWell(
            onTap: () => Navigator.of(context)
                .pushNamed(DetailScreen.routeName, arguments: t[i]),
            child: Container(
              margin: const EdgeInsets.all(5.0),
              // padding: const EdgeInsets.all(5.0),
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(232, 147, 207, 1),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(100)),
                    height: 60,
                    width: 80,
                    child: Center(
                        child: FittedBox(
                      child: Text(
                        '${format.currencySymbol} ${t[i].amount}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    )),
                  ),
                  title: Text(
                    t[i].title,
                    style: colorWhite,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(t[i].date),
                    style: colorWhite,
                  ),
                  trailing: Text(
                    t[i].spendType,
                    style: colorWhite,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    void createList() {
      if (salary.isNotEmpty) {
        addHeading("Salary", totalSalary);
        addToList(salary);
        list.add(Divider(
          color: Theme.of(context).colorScheme.secondary,
          thickness: 3,
        ));
      }

      if (gifts.isNotEmpty) {
        addHeading("Gifts", totalGifts);
        addToList(gifts);
        list.add(Divider(
          color: Theme.of(context).colorScheme.secondary,
          thickness: 3,
        ));
      }

      if (rent.isNotEmpty) {
        addHeading("Rent", totalRent);
        addToList(rent);
        list.add(Divider(
          color: Theme.of(context).colorScheme.secondary,
          thickness: 3,
        ));
      }

      if (food.isNotEmpty) {
        addHeading("Food", totalFood);
        addToList(food);
        list.add(Divider(
          color: Theme.of(context).colorScheme.secondary,
          thickness: 3,
        ));
      }

      if (transport.isNotEmpty) {
        addHeading("Transport", totalTransport);
        addToList(transport);
        list.add(Divider(
          color: Theme.of(context).colorScheme.secondary,
          thickness: 3,
        ));
      }

      if (others.isNotEmpty) {
        addHeading("Miscellaneous", totalOthers);
        addToList(others);
      }
    }

    createList();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Summary"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: list,
          ),
        ),
      ),
    );
  }
}
