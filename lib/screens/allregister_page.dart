import 'package:flutter/material.dart';
import 'package:salao/helpers/register_helper.dart';
import 'package:salao/screens/register_page.dart';
import 'package:salao/widgets/drawer_person.dart';

class AllRegister extends StatefulWidget {
  @override
  _AllRegisterState createState() => _AllRegisterState();
}

class _AllRegisterState extends State<AllRegister> {
  RegisterHelper helper = RegisterHelper();

  List<Register> register = List();
  List<Register> registerToday = List();
  List<Register> registerUndone = List();

  @override
  void initState() {
    super.initState();

    _filterRegister();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text('Agendamentos'),
        centerTitle: true,
      ),
      drawer: DrawerPerson(),
      body: ListView.builder(
        padding: EdgeInsets.only(left: 5, right: 5, top: 4),
        itemCount: registerUndone.length,
        itemBuilder: (context, index) {
          return _registerCard(context, index);
        },
      ),
    );
  }

  Widget _registerCard(BuildContext context, int index) {
    return GestureDetector(
        child: Card(
          elevation: 7,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.yellow[600], Colors.yellow[500]],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadiusDirectional.circular(12.5)),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    registerUndone[index].name.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                  Text(
                    registerUndone[index].atend ?? " ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                  Text(
                    'Data: ${registerUndone[index].date}' ?? " ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                  Text(
                    'Hora: ${registerUndone[index].hour}' ?? " ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                  RichText(
                      text: TextSpan(
                    text: 'Valor: ',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' ${registerUndone[index].value} R\$' ?? ' ',
                          style: TextStyle(
                              color: Colors.lightGreen, fontSize: 13)),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          _showOptions(context, index);
        });
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                          onPressed: () {
                            helper.updateRegister(registerUndone[index]);
                            setState(() {
                              _setDone(registerUndone, index);
                              Navigator.pop(context);
                              registerUndone.removeAt(index);
                              _filterRegister();
                            });
                          },
                          child: Text(
                            'Atendimento Concluído',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.0),
                          )),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _showRegisterPage(register: register[index]);
                          },
                          child: Text(
                            'Editar',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.0),
                          )),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                          onPressed: () {
                            helper.deleteRegister(registerUndone[index].id);
                            setState(() {
                              registerUndone.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            'Excluir',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.0),
                          )),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  void _showRegisterPage({Register register}) async {
    final recRegister = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterPage(
                  register: register,
                )));

    if (recRegister != null) {
      if (register != null) {
        await helper.updateRegister(recRegister);
      } else {
        await helper.saveRegister(recRegister);
      }
      _filterRegister();
    }
  }

  void _filterRegister() {
    register =[];
    registerUndone=[];


    helper.getAllRegisters().then((list) {
      setState(() {
        register = list;

        register.forEach((element) {
          if (element.done == '0') registerUndone.add(element);
        });

        _orderList();
      });
    });
  }

  void _setDone(register, int index) {
    register[index].done = '1';
  }

  void _orderList() {
    registerUndone.sort((a, b) {
      return a.date.toLowerCase().compareTo(b.date.toLowerCase());
    });
  }
}
