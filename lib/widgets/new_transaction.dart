// ignore_for_file: prefer_const_constructors, unnecessary_new, unnecessary_cast, unused_field, unused_import, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectedDate == null) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    _titleController.text = '';
    _amountController.text = '';

    // Close Bottom navigator
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019, 1, 1),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value as DateTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // textField for IOS platform
              // Padding(
              //   padding: EdgeInsets.fromLTRB(2, 10, 2, 5),
              //   child: CupertinoTextField(
              //     placeholder: 'Title',
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 10, 2, 5),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                  // onChanged: (val) {
                  //   titleInput = val;
                  // },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 5, 2, 10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData(),
                  // onChanged: (val) => amountInput = val,
                ),
              ),
              Container(
                height: 70,
                padding: EdgeInsets.fromLTRB(2, 5, 2, 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : DateFormat.yMd()
                                .format(_selectedDate as DateTime),
                      ),
                    ),
                    // button for IOS platform
                    // CupertinoButton(
                    //   child: Text(
                    //     'Click',
                    //   ),
                    //   onPressed: () {},
                    // ),
                    FlatButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text(
                  'Add Transaction',
                ),
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
