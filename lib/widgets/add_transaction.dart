import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function addnew;

  AddTransaction(this.addnew);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();
  DateTime selectedDate;

  void newtrans() {
    String title = titleInput.text;
    double amount = double.parse(amountInput.text);
    if (title.isEmpty || amount <= 0 || selectedDate==null) {
      return;
    }
    widget.addnew(titleInput.text, double.parse(amountInput.text),selectedDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now()).then((value) {
          if(value == null)
            {
              return;
            }
          setState(() {
            selectedDate = value;
          });

    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(left:10,right:10,top:10,bottom:
          MediaQuery.of(context).viewInsets.bottom +50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleInput,
                onSubmitted: (_) {
                  newtrans();
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountInput,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) {
                  newtrans();
                },
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(child: selectedDate == null ? Text('No Date Chosen !') :
                    Text('Picked Date: '+DateFormat.yMMMd().format(selectedDate))),
                    FlatButton(
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {_datePicker();},
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  newtrans();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
