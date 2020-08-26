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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text('Finanças Mensais'),
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
            DropDown(),
            /*Container(
              padding: EdgeInsets.only(top: 5, right: 8, left: 8, bottom: 5),
              child: ListView.builder(
                  itemCount: register.length,
                  itemBuilder: (context, index) {
                    return DropDown();
                  }),
            ), */
            Container(
              padding: EdgeInsets.only(top: 5, right: 8, left: 8, bottom: 5),
              child: ListView.builder(
                  itemCount: register.length,
                  itemBuilder: (context, index) {
                    return DropDown();
                  }),
            ),
          ],
        ),
        /*bottomNavigationBar: BottomAppBar(
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
        ),*/
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

// ignore: must_be_immutable
class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  RegisterHelper helper = RegisterHelper();

  List<Register> register = List();
  List<Register> registerFilter = List();
  List<Register> registerbyYear20 = List();
  List<Register> registerbyYear21 = List();

  double total20 = 0;
  double total21 = 0;

  Widget _gridList20(BuildContext context, int index) {
    return Card(
      elevation: 1.2,
      child: ListTile(
        title: Text(registerbyYear20[index].name),
        trailing: Text('Valor: ${registerbyYear20[index].value}'),
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
      });
    });
  }

  var _cidades = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];
  var _itemSelecionado = 'Janeiro';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: criaDropDownButton(),
    );
  }

  criaDropDownButton() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 30),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              isExpanded: true,
              items: _cidades.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(
                    dropDownStringItem,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
              onChanged: (String novoItemSelecionado) {
                _dropDownItemSelected(novoItemSelecionado);
                setState(() {

                  this._itemSelecionado = novoItemSelecionado;
                });
                _filterRegister2020();
              },
              value: _itemSelecionado,
            ),
            Expanded(
              child: Scaffold(
                body: Container(
                  padding:
                      EdgeInsets.only(top: 5, right: 8, left: 8, bottom: 5),
                  child: ListView.builder(
                      itemCount: registerbyYear20.length,
                      itemBuilder: (context, index) {
                        return _gridList20(context, index);
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      this._itemSelecionado = novoItem;
    });
  }
}
