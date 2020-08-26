import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:salao/screens/financial_monthly.dart';
import 'package:salao/screens/financial_yearly.dart';
import 'package:salao/widgets/drawer_person.dart';

class Financial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(
          'Finanças',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      drawer: DrawerPerson(),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, childAspectRatio: 1.5),
        padding: EdgeInsets.only(top: 85),
        children: <Widget>[
          Column(

            children: [
              IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                  ),
                  iconSize: 45,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => YearlyFinancial()));
                  }),
              Text(
                'Anual',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: Icon(Icons.calendar_view_day),
                  iconSize: 45,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MonthlyFinancial()));
                  }),
              Text(
                'Mensal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
