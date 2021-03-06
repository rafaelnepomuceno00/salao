import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:salao/helpers/register_helper.dart';

// ignore: must_be_immutable
class MonthlyFinancial extends StatefulWidget {
  @override
  _MonthlyFinancialState createState() => _MonthlyFinancialState();
}

class _MonthlyFinancialState extends State<MonthlyFinancial> {
  RegisterHelper helper = RegisterHelper();

  List<Register> register = List();
  List<Register> registerFilter = List();
  List<Register> registerbyYear20 = List();
  List<Register> r20jan = List();
  List<Register> r20feb = List();
  List<Register> r20mar = List();
  List<Register> r20apr = List();
  List<Register> r20may = List();
  List<Register> r20jun = List();
  List<Register> r20jul = List();
  List<Register> r20aug = List();
  List<Register> r20sep = List();
  List<Register> r20oct = List();
  List<Register> r20nov = List();
  List<Register> r20dec = List();
  List<Register> registerbyYear21 = List();
  List<Register> r21jan = List();
  List<Register> r21feb = List();
  List<Register> r21mar = List();
  List<Register> r21apr = List();
  List<Register> r21may = List();
  List<Register> r21jun = List();
  List<Register> r21jul = List();
  List<Register> r21aug = List();
  List<Register> r21sep = List();
  List<Register> r21oct = List();
  List<Register> r21nov = List();
  List<Register> r21dec = List();

  double total20jan = 0;
  double total20feb = 0;
  double total20mar = 0;
  double total20apr = 0;
  double total20may = 0;
  double total20jun = 0;
  double total20jul = 0;
  double total20aug = 0;
  double total20sep = 0;
  double total20oct = 0;
  double total20nov = 0;
  double total20dec = 0;
  double total21jan = 0;
  double total21feb = 0;
  double total21mar = 0;
  double total21apr = 0;
  double total21may = 0;
  double total21jun = 0;
  double total21jul = 0;
  double total21aug = 0;
  double total21sep = 0;
  double total21oct = 0;
  double total21nov = 0;
  double total21dec = 0;

  double total = 0;
  String _selectedMonth;

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
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 65, right: 65, top: 10),
                  child: DropdownButton(
                    disabledHint: Text('Selecione o Mês'),
                    isExpanded: true,
                    value: _selectedMonth,
                    items: _dropDownItem(),
                    onChanged: (value) {
                      _selectedMonth = value;
                      setState(() {});
                    },
                    hint: Text('Selecione um Mês '),
                  ),
                ),
                Expanded(child: _buildScaffold20(context)),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 65, right: 65, top: 10),
                  child: DropdownButton(
                    disabledHint: Text('Selecione o Mês'),
                    isExpanded: true,
                    value: _selectedMonth,
                    items: _dropDownItem(),
                    onChanged: (value) {
                      _selectedMonth = value;
                      setState(() {});
                    },
                    hint: Text('Selecione um Mês '),
                  ),
                ),
                Expanded(
                  child: _buildScaffold21(context),
                ),
              ],
            ),
          ],
        ),
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
            registerbyYear20.add(element);
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('janeiro')) {
            r20jan.add(element);
            _orderList(r20jan);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total20jan += valor;
          }
        });

        registerbyYear20.forEach((element) {
          if (element.date.contains('fevereiro')) {
            r20feb.add(element);
            _orderList(r20feb);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total20feb += valor;
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('março')) {
            r20mar.add(element);
            _orderList(r20mar);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total20mar += valor;
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('abril')) {
            r20apr.add(element);
            _orderList(r20apr);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total20apr += valor;
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('maio')) {
            r20may.add(element);
            _orderList(r20may);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total20may += valor;
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('junho')) {
            r20jun.add(element);
            _orderList(r20jun);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total20jun += valor;
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('julho')) {
            r20jul.add(element);
            _orderList(r20jul);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total20jul += valor;
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('agosto')) {
            r20aug.add(element);
            _orderList(r20aug);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total20aug += valor;
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('setembro')) {
            r20sep.add(element);
            _orderList(r20sep);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total20sep += valor;
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('outubro')) {
            r20oct.add(element);
            _orderList(r20oct);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total20oct += valor;
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('novembro')) {
            r20nov.add(element);
            _orderList(r20nov);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total20nov += valor;
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('dezembro')) {
            r20dec.add(element);
            _orderList(r20dec);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total20dec += valor;
          }
        });
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
            registerbyYear21.add(element);
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('janeiro')) {
            r21jan.add(element);
            _orderList(r21jan);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total21jan += valor;
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('fevereiro')) {
            r21feb.add(element);
            _orderList(r21feb);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total21feb += valor;
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('março')) {
            r21mar.add(element);
            _orderList(r21mar);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total21mar += valor;
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('abril')) {
            r21apr.add(element);
            _orderList(r21apr);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total21apr += valor;
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('maio')) {
            r21may.add(element);
            _orderList(r21may);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total21may += valor;
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('junho')) {
            r21jun.add(element);
            _orderList(r21jun);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total21jun += valor;
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('julho')) {
            r21jul.add(element);
            _orderList(r21jul);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total21jul += valor;
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('agosto')) {
            r21aug.add(element);
            _orderList(r21aug);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total21aug += valor;
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('setembro')) {
            r21sep.add(element);
            _orderList(r21sep);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total21sep += valor;
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('outubro')) {
            r21oct.add(element);
            _orderList(r21oct);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total21oct += valor;
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('novembro')) {
            r21nov.add(element);
            _orderList(r21nov);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total21nov += valor;
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('dezembro')) {
            r21dec.add(element);
            _orderList(r21dec);
            var valor = double.parse(element.value.replaceAll(',', '.'));
            assert(valor is double);
            total21dec += valor;
          }
        });
      });
    });
  }

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> ddl = [
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
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
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

  // ignore: missing_return
  Widget _buildScaffold20(BuildContext context) {
    switch (_selectedMonth) {
      case 'Janeiro':
        {
          return Expanded(child: _monthlyScaffold(context, r20jan, total20jan));
        }
        break;
      case 'Fevereiro':
        {
          return Expanded(child: _monthlyScaffold(context, r20feb, total20feb));
        }
        break;
      case 'Março':
        {
          return Expanded(child: _monthlyScaffold(context, r20mar, total20mar));
        }
        break;
      case 'Abril':
        {
          return Expanded(child: _monthlyScaffold(context, r20apr, total20apr));
        }
        break;
      case 'Maio':
        {
          return Expanded(child: _monthlyScaffold(context, r20may, total20may));
        }
        break;
      case 'Junho':
        {
          return Expanded(child: _monthlyScaffold(context, r20jun, total20jun));
        }
        break;
      case 'Julho':
        {
          return Expanded(child: _monthlyScaffold(context, r20jul, total20jul));
        }
        break;
      case 'Agosto':
        {
          return Expanded(child: _monthlyScaffold(context, r20aug, total20aug));
        }
        break;
      case 'Setembro':
        {
          return Expanded(child: _monthlyScaffold(context, r20sep, total20sep));
        }
        break;
      case 'Outubro':
        {
          return Expanded(child: _monthlyScaffold(context, r20oct, total20oct));
        }
        break;
      case 'Novembro':
        {
          return Expanded(child: _monthlyScaffold(context, r20nov, total20nov));
        }
        break;
      case 'Dezembro':
        {
          return Expanded(child: _monthlyScaffold(context, r20dec, total20dec));
        }
        break;
      default:
        return Scaffold(
          body: Center(
            child: Container(
              child: Text('Selecione um mês'),
            ),
          ),
        );
    }
  }

  // ignore: missing_return
  Widget _buildScaffold21(BuildContext context) {
    switch (_selectedMonth) {
      case 'Janeiro':
        {
          return Expanded(child: _monthlyScaffold(context, r21jan, total21jan));
        }
        break;
      case 'Fevereiro':
        {
          return Expanded(child: _monthlyScaffold(context, r21feb, total21feb));
        }
        break;
      case 'Março':
        {
          return Expanded(child: _monthlyScaffold(context, r21mar, total21mar));
        }
        break;
      case 'Abril':
        {
          return Expanded(child: _monthlyScaffold(context, r21apr, total21apr));
        }
        break;
      case 'Maio':
        {
          return Expanded(
            child: _monthlyScaffold(context, r21may, total21may),
          );
        }
        break;
      case 'Junho':
        {
          return Expanded(child: _monthlyScaffold(context, r21jun, total21jun));
        }
        break;
      case 'Julho':
        {
          return Expanded(child: _monthlyScaffold(context, r21jul, total21jul));
        }
        break;
      case 'Agosto':
        {
          return Expanded(child: _monthlyScaffold(context, r21aug, total21aug));
        }
        break;
      case 'Setembro':
        {
          return Expanded(child: _monthlyScaffold(context, r21sep, total21sep));
        }
        break;
      case 'Outubro':
        {
          return Expanded(child: _monthlyScaffold(context, r21oct, total21oct));
        }
        break;
      case 'Novembro':
        {
          return Expanded(child: _monthlyScaffold(context, r21nov, total21nov));
        }
        break;
      case 'Dezembro':
        {
          return Expanded(child: _monthlyScaffold(context, r21dec, total21dec));
        }
        break;
      default:
        return Scaffold(
          body: Center(
            child: Container(
              child: Text('Selecione um mês'),
            ),
          ),
        );
    }
  }

  @widget
  Widget _monthlyScaffold(BuildContext context, List mList, double mValue) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 5, right: 3.5, left: 3.5, bottom: 5),
        child: ListView.builder(
            itemCount: mList.length,
            itemBuilder: (context, index) {
              return _gridList(context, index, mList);
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
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
                '  Valor: ${mValue.toStringAsFixed(2)}',
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

  void _orderList(List registerList) {
    registerList.sort((a, b) {
      return a.date.toLowerCase().compareTo(b.date.toLowerCase());
    });
  }
}
