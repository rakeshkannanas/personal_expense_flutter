import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_expense/models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function delTx;

  static const List<Color> colorslist = [
    Colors.red,
    Colors.blueGrey,
    Colors.yellow,
    Colors.black
  ];
  Color bgColor = colorslist[Random().nextInt(4)];

  TransactionList(this.transactions, this.delTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(children: [
              Container(
                height: constraints.maxHeight * 0.2,
                child: Center(
                  child: Text(
                    'No transactions added yet!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/notrans.png',
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: constraints.maxHeight * 0.2,
              ),
            ]);
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: bgColor,
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            child: Text(
                              '₹${transactions[index].amount}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: TextStyle(
                            letterSpacing: 2.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: TextStyle(
                            letterSpacing: 2.0, fontWeight: FontWeight.bold),
                      ),
                      trailing: MediaQuery.of(context).size.width < 450
                          ? IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).errorColor,
                              ),
                              onPressed: () {
                                delTx(transactions[index].id);
                              },
                            )
                          : FlatButton.icon(
                              onPressed: () {
                                delTx(transactions[index].id);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).errorColor,
                              ),
                              label: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Theme.of(context).errorColor,
                                ),
                              ))));
            },
            itemCount: transactions.length,
          );
  }
}
