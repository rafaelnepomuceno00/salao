import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:salao/helpers/register_helper.dart';

// ignore: must_be_immutable
class MonthlyFinancial extends StatefulWidget {
  @override
  _MonthlyFinancialState createState() => _MonthlyFinancialState();
}

class _MonthlyFinancialState extends State<MonthlyFinancial> {
  RegisterHelper helper = RegisterHelper();

  List<Register> register = List();
  double total = 0;

  @override
  void initState() {
    super.initState();

    _filterRegister();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finanças Mensais'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5, right: 8,left: 8, bottom: 5),
        child: ListView.builder(
            itemCount: register.length,
            itemBuilder: (context, index) {
              return _gridList(context, index);
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        color: Colors.pinkAccent,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text(
                '  Total:',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                '  Valor: ${total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _gridList(BuildContext context, int index) {
    return Card(
      elevation: 1.2,
      child: ListTile(
        title: Text(register[index].name),
        trailing: Text('Valor: ${register[index].value}'),
      ),
    );
  }

  void _filterRegister() {
    helper.getAllRegisters().then((list) {
      register = list;

      register.forEach((element) {
        var valor = double.parse(element.value.replaceAll(',', '.'));
        assert(valor is double);

        if (element.done == '1')
          setState(() {
            total += valor;
            register = list;
          });
      });
    });
  }
}
