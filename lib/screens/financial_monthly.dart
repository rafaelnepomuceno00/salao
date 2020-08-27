import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  double total20 = 0;
  double total21 = 0;
  double total = 0;
  String aug = 'Agosto';
  String _selectedMonth;

  @override
  void initState() {
    super.initState();
    _filterRegister2020();
    _filterRegister2021();
    mexernalista();
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
                Expanded(
                  child: _buildScafold20(context),
                ),
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
                  child: _buildScafold21(context),
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
          if (element.date.contains('Janeiro')) {
            r20jan.add(element);
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('Fevereiro')) {
            r20feb.add(element);
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('Março')) {
            r20mar.add(element);
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('Abril')) {
            r20apr.add(element);
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('Maio')) {
            r20may.add(element);
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('Junho')) {
            r20jun.add(element);
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('Julho')) {
            r20jul.add(element);
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('Agosto') ) {
            r20aug.add(element);


          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('Setembro')) {
            r20sep.add(element);
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('Outubro')) {
            r20oct.add(element);
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('Novembro')) {
            r20nov.add(element);
          }
        });
        registerbyYear20.forEach((element) {
          if (element.date.contains('Dezembro')) {
            r20dec.add(element);
          }
        });
      });
    });
    print(registerbyYear20);
    print(r20aug);
    print(registerFilter);
  }

  void mexernalista(){
    registerbyYear20.forEach((element) {
      if(element.date.contains('agosto')){
        r20aug.add(element);
      }
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
        registerbyYear21.forEach((element) {
          if (element.date.contains('Janeiro')) {
            r21jan.add(element);
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('Fevereiro')) {
            r21feb.add(element);
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('Março')) {
            r21mar.add(element);
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('Abril')) {
            r21apr.add(element);
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('Maio')) {
            r21may.add(element);
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('Junho')) {
            r21jun.add(element);
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('Julho')) {
            r21jul.add(element);
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('Agosto')) {
            r21aug.add(element);
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('Setembro')) {
            r21sep.add(element);
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('Outubro')) {
            r21oct.add(element);
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('Novembro')) {
            r21nov.add(element);
          }
        });
        registerbyYear21.forEach((element) {
          if (element.date.contains('Dezembro')) {
            r21dec.add(element);
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
        trailing: Text('Valor: ${register[index].value}'),
      ),
    );
  }

  Widget _buildScafold20(BuildContext context) {
    switch (_selectedMonth) {
      case 'Janeiro':
        {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.only(top: 5, right: 8, left: 8, bottom: 5),
              child: ListView.builder(
                  itemCount: r20jan.length,
                  itemBuilder: (context, index) {
                    return _gridList(context, index, r20jan);
                  }),
            ),
          );
        }

      case 'Fevereiro':
        {
          return Scaffold(
            body: Container(
              child: Text('Fevereiro'),
            ),
          );
        }
        break;
      case 'Março':
        {
          return Scaffold(
            body: Container(
              child: Text('Março'),
            ),
          );
        }
        break;
      case 'Abril':
        {
          return Scaffold(
            body: Container(
              child: Text('Abril'),
            ),
          );
        }
        break;
      case 'Maio':
        {
          return Scaffold(
            body: Container(
              child: Text('Maio'),
            ),
          );
        }
        break;
      case 'Junho':
        {
          return Scaffold(
            body: Container(
              child: Text('Junho'),
            ),
          );
        }
        break;
      case 'Julho':
        {
          return Scaffold(
            body: Container(
              child: Text('Julho'),
            ),
          );
        }
        break;
      case 'Agosto':
        {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.only(top: 5, right: 8, left: 8, bottom: 5),
              child: ListView.builder(
                  itemCount: r20aug.length,
                  itemBuilder: (context, index) {
                    return _gridList(context, index, r20aug);

                  }),
            ),
          );
        }
        break;
      case 'Setembro':
        {
          return Scaffold(
            body: Container(
              child: Text('Setembro'),
            ),
          );
        }
        break;
      case 'Outubro':
        {
          return Scaffold(
            body: Container(
              child: Text('Outubro'),
            ),
          );
        }
        break;
      case 'Novembro':
        {
          return Scaffold(
            body: Container(
              child: Text('Novembro'),
            ),
          );
        }
        break;
      case 'Dezembro':
        {
          return Scaffold(
            body: Container(
              child: Text('Dezembro'),
            ),
          );
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

  Widget _buildScafold21(BuildContext context) {
    switch (_selectedMonth) {
      case 'Janeiro':
        {
          return Scaffold(
            body: Container(
              child: Text('Janeiro'),
            ),
          );
        }

      case 'Fevereiro':
        {
          return Scaffold(
            body: Container(
              child: Text('Fevereiro'),
            ),
          );
        }
        break;
      case 'Março':
        {
          return Scaffold(
            body: Container(
              child: Text('Março'),
            ),
          );
        }
        break;
      case 'Abril':
        {
          return Scaffold(
            body: Container(
              child: Text('Abril'),
            ),
          );
        }
        break;
      case 'Maio':
        {
          return Scaffold(
            body: Container(
              child: Text('Maio'),
            ),
          );
        }
        break;
      case 'Junho':
        {
          return Scaffold(
            body: Container(
              child: Text('Junho'),
            ),
          );
        }
        break;
      case 'Julho':
        {
          return Scaffold(
            body: Container(
              child: Text('Julho'),
            ),
          );
        }
        break;
      case 'Agosto':
        {
          return Scaffold(
            body: Container(
              child: Text('Agosto'),
            ),
          );
        }
        break;
      case 'Setembro':
        {
          return Scaffold(
            body: Container(
              child: Text('Setembro'),
            ),
          );
        }
        break;
      case 'Outubro':
        {
          return Scaffold(
            body: Container(
              child: Text('Outubro'),
            ),
          );
        }
        break;
      case 'Novembro':
        {
          return Scaffold(
            body: Container(
              child: Text('Novembro'),
            ),
          );
        }
        break;
      case 'Dezembro':
        {
          return Scaffold(
            body: Container(
              child: Text('Dezembro'),
            ),
          );
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
}
