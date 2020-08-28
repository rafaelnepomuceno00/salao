
import 'package:flutter/material.dart';
import 'package:salao/helpers/register_helper.dart';
import 'package:salao/widgets/drawer_person.dart';


class Historic extends StatefulWidget {
  @override
  _HistoricState createState() => _HistoricState();
}

class _HistoricState extends State<Historic> {

  RegisterHelper helper = RegisterHelper();

  List<Register> register = List();
  List<Register> registerToday = List();
  List<Register> registerDone = List();

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
        title: Text(
          'Atendimentos Concluídos',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: DrawerPerson(),
      body: ListView.builder(
        padding: EdgeInsets.only(left: 5, right: 5, top: 4),
        itemCount: registerDone.length,
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
          color: Color.fromARGB(100, 250, 65, 200),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  registerDone[index].name.toString(),
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                Text(
                  registerDone[index].atend ?? " ",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                Text(
                  'Data: ${registerDone[index].date}' ?? " ",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                Text(
                  'Hora: ${registerDone[index].hour}' ?? " ",
                  style: TextStyle(
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
                            text: ' ${registerDone[index].value} R\$' ?? ' ',
                            style: TextStyle(
                                color: Colors.lightGreenAccent, fontSize: 13)),
                      ],
                    )),
              ],
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
                            helper.deleteRegister(registerDone[index].id);
                            setState(() {
                              registerDone.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            'Excluir',
                            style: TextStyle(
                                color: Colors.pinkAccent, fontSize: 20.0),
                          )),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }





  void _filterRegister() {

    register = [];
    registerDone=[];


    helper.getAllRegisters().then((list) {
      setState(() {
        register = list;
      register.forEach((element) {
          if (element.done == '1') registerDone.add(element);
        });
      });

      _orderList();
    });
  }

  void _orderList() {
    registerDone.sort((a, b) {
      return a.date.toLowerCase().compareTo(b.date.toLowerCase());

    });


  }
}