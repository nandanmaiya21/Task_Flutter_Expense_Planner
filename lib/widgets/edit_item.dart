import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/expenses.dart';
import 'package:intl/intl.dart';
import '../widgets/edit_transaction.dart';

class EditItem extends StatelessWidget {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final String spendType;

  EditItem({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
    @required this.category,
    @required this.spendType,
  });

  void _startEditTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: EditTransaction(
            id: id,
            title: title,
            amount: amount,
            category: category,
            date: date,
            spendType: spendType,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var format = NumberFormat.simpleCurrency(locale: 'en_IN');
    TextStyle colorWhite = const TextStyle(color: Colors.white);
    return InkWell(
      onTap: () => _startEditTransaction(context),
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
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(100)),
              height: 60,
              width: 80,
              child: Center(
                  child: FittedBox(
                child: Text(
                  '${format.currencySymbol} ${amount}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
