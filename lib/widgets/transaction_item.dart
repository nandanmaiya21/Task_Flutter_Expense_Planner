import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/expenses.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final String spendType;

  TransactionItem({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
    @required this.category,
    @required this.spendType,
  });

  @override
  Widget build(BuildContext context) {
    var format = NumberFormat.simpleCurrency(locale: 'en_IN');
    TextStyle colorWhite = const TextStyle(color: Colors.white);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Do you want to remove the item from thw cart"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("No")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Yes"))
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Expenses>(context, listen: false).deleteTransaction(id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.primary),
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(232, 147, 207, 1),
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(100)),
              height: 60,
              width: 80,
              child: Center(
                  child: FittedBox(
                child: Text(
                  '${format.currencySymbol} ${amount}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              )),
            ),
            title: Text(
              title,
              style: colorWhite,
            ),
            subtitle: Text(DateFormat.yMMMd().format(date), style: colorWhite),
            trailing: Text(spendType, style: colorWhite),
          ),
        ),
      ),
    );
  }
}
