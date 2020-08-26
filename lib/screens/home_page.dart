import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salao/helpers/register_helper.dart';
import 'package:salao/screens/register_page.dart';
import 'package:salao/widgets/drawer_person.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _calendarController = CalendarController();
  RegisterHelper helper = RegisterHelper();

  List<Register> register = List();
  List<Register> registerToday = List();
  List<Register> registerUndone = [];

  DateTime dateCheck;

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
        title: Text('Salão Marina'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      drawer: DrawerPerson(),
      body: registerUndone.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.only(left: 5, right: 5, top: 4),
              itemCount: registerUndone.length,
              itemBuilder: (context, index) {
                return _registerCard(context, index);
              },
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Card(
                      margin:
                          EdgeInsets.only(top: 5, right: 5, left: 5, bottom: 5),
                      child: Text(
                        'Não há agendamentos hoje.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      color: Color.fromARGB(255, 173, 255, 200),
                    ),
                    Divider(
                      color: Colors.pinkAccent,
                    ),
                    TableCalendar(
                      calendarController: _calendarController,
                      locale: ('pt' 'br'),
                      calendarStyle: CalendarStyle(
                        todayColor: Colors.lightGreen,
                      ),
                    ),
                    Divider(
                      color: Colors.pinkAccent,
                    ),
                  ],
                ),
              ),
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
                  registerUndone[index].name.toString(),
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                Text(
                  registerUndone[index].atend ?? " ",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                Text(
                  'Data: ${registerUndone[index].date}' ?? " ",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                Text(
                  'Hora: ${registerUndone[index].hour}' ?? " ",
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
                        text: ' ${registerUndone[index].value} R\$' ?? ' ',
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
                            helper.updateRegister(registerUndone[index]);
                            setState(() {
                              _setDone(registerUndone, index);
                              Navigator.pop(context);
                              registerUndone.removeAt(index);
                              _filterRegister();
                            });
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
                            _showRegisterPage(register: registerUndone[index]);
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
                            helper.deleteRegister(registerUndone[index].id);
                            setState(() {
                              registerUndone.removeAt(index);
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
        DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY, 'pt_br');
    formatter.format(now);
    helper.getAllRegisters().then((list) {
      setState(() {
        register = list;
        register.forEach((element) {
          var convertDate = element.date;
          var dateTimeTab =
              DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_br').parse(convertDate);

          if (dateTimeTab.difference(now).inDays == 0) {
            registerToday.add(element);
          }
        });
        registerToday.forEach((element) {
          if (element.done == '0') registerUndone.add(element);
        });
      });
    });
  }

  void _setDone(register, int index) {
    register[index].done = '1';
  }
}
