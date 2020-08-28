import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salao/helpers/register_helper.dart';

// ignore: must_be_immutable
class YearlyFinancial extends StatefulWidget {
  @override
  _YearlyFinancialState createState() => _YearlyFinancialState();
}

class _YearlyFinancialState extends State<YearlyFinancial> {
  RegisterHelper helper = RegisterHelper();

  List<Register> register = List();
  List<Register> registerFilter = List();
  List<Register> registerbyYear20 = List();
  List<Register> registerbyYear21 = List();

  double total20 = 0;
  double total21 = 0;

  @override
  void initState() {
    super.initState();
    _filterRegister2020();
    _filterRegister2021();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text('Finanças Anuais'),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: '2020',
              ),
              Tab(
                text: '2021',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              body: Container(
                padding: EdgeInsets.only(top: 5, right: 8, left: 8, bottom: 5),
                child: ListView.builder(
                    itemCount: registerbyYear20.length,
                    itemBuilder: (context, index) {
                      return _gridList(context, index, registerbyYear20);
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
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        '  Valor: ${total20.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Scaffold(
              body: Container(
                padding: EdgeInsets.only(top: 5, right: 8, left: 8, bottom: 5),
                child: ListView.builder(
                    itemCount: registerbyYear21.length,
                    itemBuilder: (context, index) {
                      return _gridList(context, index, registerbyYear21);
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
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        '  Valor: ${total21.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridList(BuildContext context, int index, List register) {
    return Card(
      elevation: 1.2,
      child: ListTile(
        title: Text(register[index].name),
        subtitle: Text(register[index].date),
        trailing: Text('Valor: ${register[index].value}'),
      ),
    );

  }

  void _filterRegister2020() {
    helper.getAllRegisters().then((list) {
      setState(() {
        register = list;
        register.forEach((element) {
          if (element.done == '1') registerFilter.add(element);
        });
        registerFilter.forEach((element) {
          if (element.date.contains('2020')) {
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total20 += valor;
            registerbyYear20.add(element);
          }
        });

        _orderList(registerbyYear20);
      });
    });
  }

  void _filterRegister2021() {
    helper.getAllRegisters().then((list) {
      setState(() {
        register = list;
        register.forEach((element) {
          if (element.done == '1') registerFilter.add(element);
        });
        registerFilter.forEach((element) {
          if (element.date.contains('2021')) {
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total21 += valor;
            registerbyYear21.add(element);
          }
        });

        _orderList(registerbyYear21);
      });
    });
  }

  void _orderList(List registerList) {
    registerList.sort((a, b) {
      return a.date.toLowerCase().compareTo(b.date.toLowerCase());
    });
  }
}
