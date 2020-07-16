import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_expense/widgets/chart_bar.dart';
import '../models/transactions.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTrans;

  Chart(this.recentTrans);

  var totalSum = 0.0;

  List<Map<String, Object>> get transactionDetails {
    totalSum = 0.0;
    return List.generate(7, (index) {
      final currentday = DateTime.now().subtract(Duration(days: index));
      var totalSumPerDay = 0.0;
      for (var i = 0; i < recentTrans.length; i++) {
        if (recentTrans[i].date.day == currentday.day &&
            recentTrans[i].date.month == currentday.month &&
            recentTrans[i].date.year == currentday.year) {
          totalSumPerDay += recentTrans[i].amount;
        }
      }
      totalSum += totalSumPerDay;
      return {
        'day': DateFormat.E().format(currentday).substring(0, 1),
        'amount': totalSumPerDay
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    print(transactionDetails.toString());
    print(totalSum.toString());
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: transactionDetails.map((data) {
            return ChartBar(
              day: data['day'],
              amount: data['amount'],
              percentageSpent: totalSum == 0.0 ? 0.0 : (data['amount'] as double) / totalSum,
            );
          }).toList(),
        ),
      ),
    );
  }
}
