import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner_app/provider/expenses.dart';
import 'package:provider/provider.dart';

class NewTransaction extends StatefulWidget {
  @override
  State<NewTransaction> createState() {
    print('createState NewTransaction Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _dropDownValue;
  String _spendType;
  DateTime _selectedDate;

  _NewTransactionState() {
    print('Constructor new Transaction State');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        _selectedDate == null ||
        _dropDownValue == null ||
        _spendType == null) {
      return;
    }

    // widget.addTx(
    //   enteredTitle,
    //   enteredAmount,
    //   _dropDownValue,
    //   _selectedDate,
    //   _spendType,
    // );

    Provider.of<Expenses>(context, listen: false).addTransaction(
      title: enteredTitle,
      amount: enteredAmount,
      category: _dropDownValue,
      date: _selectedDate,
      spendType: _spendType,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void dropDownCallback(String selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropDownValue = selectedValue;
      });
    }
  }

  void spendDropDownCallBack(String selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _spendType = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              const SizedBox(height: 10),
              DropdownButton(
                hint: const Text("Category"),
                items: const [
                  DropdownMenuItem(
                    value: "Salary",
                    child: Text("Salary"),
                  ),
                  DropdownMenuItem(
                    value: "Gifts",
                    child: Text("Gifts"),
                  ),
                  DropdownMenuItem(
                    value: "Rent",
                    child: Text("Rent"),
                  ),
                  DropdownMenuItem(
                    value: "Food",
                    child: Text("Food"),
                  ),
                  DropdownMenuItem(
                    value: "Transport",
                    child: Text("Transport"),
                  ),
                  DropdownMenuItem(
                    value: "Others",
                    child: Text(
                      "Others",
                    ),
                  ),
                ],
                value: _dropDownValue,
                onChanged: dropDownCallback,
                isExpanded: true,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              DropdownButton(
                hint: const Text("Expense/Income"),
                items: const [
                  DropdownMenuItem(
                    value: "Expense",
                    child: Text("Expense"),
                  ),
                  DropdownMenuItem(
                    value: "Income",
                    child: Text("Income"),
                  ),
                ],
                value: _spendType,
                onChanged: spendDropDownCallBack,
                isExpanded: true,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      style: _selectedDate == null
                          ? TextStyle(color: Colors.red)
                          : TextStyle(),
                    ),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: Text('Add Transaction'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColorDark),
                    onPressed: _submitData,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
