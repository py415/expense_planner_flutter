import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  // Handle calculation for transaction.
  final Function addTx;

  NewTransaction({@required this.addTx});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // Controller for title text field.
  final _titleController = TextEditingController();
  // Controller for amount spent text field.
  final _amountController = TextEditingController();
  // Used to set selected date.
  DateTime _selectedDate;

  // Submit new transaction.
  void _submitData() {
    // Title text field.
    final enteredTitle = _titleController.text;
    // Amount spent text field.
    final enteredAmount = double.parse(_amountController.text);

    // Text field validation
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    // Add new transaction.
    widget.addTx(
      txTitle: enteredTitle,
      txAmount: enteredAmount,
      txDate: _selectedDate,
    );

    // Close out transaction after user submits new transaction form.
    Navigator.of(context).pop();
  }

  // Method for handling date selection.
  void _presentDatePicker() {
    // Show date picker.
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      // If date is not selected, close date picker pop up with no date selected.
      if (pickedDate == null) {
        return;
      }

      // Set date selected from date picker.
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveFlatButton('Choose Date', _presentDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
