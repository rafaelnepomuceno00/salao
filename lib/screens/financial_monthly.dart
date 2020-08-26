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
  double total = 0;

  String _selectedMonth ;

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
                  child: _buildScafold(context),
                ),
              ],
            ),
            Container(
              color: Colors.white,
            ),
          ],
        ),
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

  Widget _buildScafold(BuildContext context) {
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
        return
          Scaffold(
            body: Center(
              child: Container(
                child: Text('Selecione um mês'),
              ),
            ),
          );
    }
  }
}
