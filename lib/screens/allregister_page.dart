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

  @override
  void initState() {
    super.initState();

    _getAllRegister();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('logo que carla fizer'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      drawer: DrawerPerson(),
      body: ListView.builder(
        padding: EdgeInsets.only(left: 5, right: 5, top: 4),
        itemCount: register.length,
        itemBuilder: (context, index) {
          return _registerCard(context, index);
        },
      ),
    );
  }

  Widget _registerCard(BuildContext context, int index) {
    return GestureDetector(
        child: Card(
          color: Color.fromARGB(100, 250, 65, 200),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  register[index].name.toString(),
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                Text(
                  register[index].atend ?? " ",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Data: ${register[index].date}' ?? " ",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Hora: ${register[index].hour}' ?? " ",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                RichText(
                    text: TextSpan(
                      text: 'Valor: ',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' ${register[index].value} R\$' ?? ' ',
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
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Atendimento Concluído',
                            style: TextStyle(
                                color: Colors.pinkAccent, fontSize: 20.0),
                          )),
                    ),
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
                                color: Colors.pinkAccent, fontSize: 20.0),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                          onPressed: () {
                            helper.deleteRegister(register[index].id);
                            setState(() {
                              register.removeAt(index);
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
      _getAllRegister();
    }
  }

  void _getAllRegister() {
    helper.getAllRegisters().then((list) {
      setState(() {
        register = list;
      });
    });
  }
}

