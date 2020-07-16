import 'package:flutter/material.dart';

import './widgets/add_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transactions.dart';

void main() {
  runApp(MaterialApp(
    home: Main(),
    theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.lightGreen,
        fontFamily: 'Quicksand'),
  ));
}
bool _showSwitch = false;
void addTrans(BuildContext ctx, Function add) {
  showModalBottomSheet(
      context: ctx,
      builder: (bctx) {
        return AddTransaction(add);
      });
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final List<Transactions> _transactions = [
//    Transactions(
//        id: 't1', title: 'New Shades', amount: 900.00, date: DateTime.now()),
//    Transactions(
//        id: 't2', title: 'Groceries', amount: 789.00, date: DateTime.now()),
  ];

  List<Transactions> lastSevenDaysTr() {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTrans(String txTitle, double txAmount, DateTime date) {
    Transactions newtx = Transactions(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: date);

    setState(() {
      _transactions.add(newtx);
    });
  }

  AppBar _androidBar ()
  {
    return AppBar(
      title: Text(
        'Weekly Expense',
        style: TextStyle(
            color: Colors.white,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            addTrans(context, _addNewTrans);
          },
        )
      ],
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  void delTrans(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = _androidBar();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if(isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch.adaptive(activeColor: Theme.of(context).accentColor,
                  value: _showSwitch,
                onChanged: (val){
                  setState(() {
                    _showSwitch =val;
                  });
                },),
              ],
            ),
            if(isLandscape)
            _showSwitch ?
            Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        appBar.preferredSize.height) *
                    0.7,
                child: Chart(lastSevenDaysTr())) :
            Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        appBar.preferredSize.height) *
                    0.7,
                child: TransactionList(_transactions, delTrans)),
            if(!isLandscape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      appBar.preferredSize.height) *
                      0.3,
                  child: Chart(lastSevenDaysTr())) ,
            if(!isLandscape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      appBar.preferredSize.height) *
                      0.7,
                  child: TransactionList(_transactions, delTrans)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addTrans(context, _addNewTrans);
        },
      ),
    );
  }
}
