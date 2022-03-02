import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final String? id;
  final String? title;
  final double? amount;
  final DateTime? date;
  final Function? txDelete;

  TransactionItem({this.id, this.title, this.amount, this.date, this.txDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                '\$${this.amount}',
              ),
            ),
          ),
        ),
        title: Text(
          this.title.toString(),
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(this.date as DateTime),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                onPressed: () {
                  this.txDelete!(this.id);
                },
                icon: Icon(Icons.delete),
                label: Text('Delete'),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  this.txDelete!(this.id);
                },
                iconSize: 30,
                color: Colors.blue,
              ),
      ),
    );
  }
}
