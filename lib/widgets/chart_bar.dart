import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day ;
  final double amount;
  final double percentageSpent;
  ChartBar({this.day,this.amount,this.percentageSpent});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){
     return Column(
        children: [
          Container(height: constraints.maxHeight*0.13,child: FittedBox(child: Text('$amount'))),
          SizedBox(height: constraints.maxHeight*0.05,),
          Container(
            height: constraints.maxHeight*0.6,
            width: 12,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 2,),
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(heightFactor: percentageSpent,
                  child: Container(
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),)
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight*0.05,),
          Container(height: constraints.maxHeight*0.13,child: FittedBox(child: Text(day)))
        ],
      );
    }
    );
  }
}
