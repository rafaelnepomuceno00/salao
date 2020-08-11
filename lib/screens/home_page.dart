import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salao/helpers/register_helper.dart';
import 'package:salao/screens/register_page.dart';
import 'package:salao/widgets/drawer_person.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RegisterHelper helper = RegisterHelper();

  List<Register> register = List();
  List<Register> registerToday = List();

  DateTime dateCheck;

  @override
  void initState() {

    super.initState();

    dateCheck = DateTime.now();

    _filterRegister();
    setState(() {

    });
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
        itemCount: registerToday.length,
        itemBuilder: (context, index) {
          return _registerCard(context, index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showRegisterPage();
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
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
                  registerToday[index].name.toString(),
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                Text(
                  registerToday[index].atend ?? " ",
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
                        'Data: ${registerToday[index].date}' ?? " ",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Hora: ${registerToday[index].hour}' ?? " ",
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
                        text: ' ${registerToday[index].value} R\$' ?? ' ',
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
                            helper.updateRegister(registerToday[index]);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Atendimento concluído',
                            style: TextStyle(
                                color: Colors.pinkAccent, fontSize: 20.0),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _showRegisterPage(register: registerToday[index]);
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
                            helper.deleteRegister(registerToday[index].id);
                            setState(() {
                              registerToday.removeAt(index);
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
      _filterRegister();
    }
  }

  void _filterRegister() {
    final DateTime now = DateTime.now();
    final DateFormat formatter =
        DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY, 'pt_BR');
    final String formatted = formatter.format(now);

    helper.getAllRegisters().then((list) {
      register = list;

      register.forEach((element) {
        if (element.date == formatted) {
          registerToday.add(element);

        }
      });
      setState(() {
        registerToday = list;
      });
    });
  }
}
