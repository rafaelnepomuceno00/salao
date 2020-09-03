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
        title: Text('Babearia'),
        centerTitle: true,
      ),
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
                      child: Container(
                        margin: EdgeInsets.all(4.5),
                        child: Text(
                          'Não há agendamentos hoje.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      color: Color.fromARGB(255, 255, 255, 100),
                    ),
                    Divider(
                      color: Theme.of(context).accentColor,
                    ),
                    TableCalendar(
                      calendarController: _calendarController,
                      locale: ('pt' 'br'),
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        weekendStyle:
                            TextStyle().copyWith(color: Colors.yellow[300]),
                        weekdayStyle:
                            TextStyle().copyWith(color: Colors.yellow[600]),
                        holidayStyle:
                            TextStyle().copyWith(color: Colors.yellow[300]),
                        selectedColor:
                        Colors.red[400],
                        todayColor: Colors.red[300],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).accentColor,
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
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
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
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return BottomSheet(
            backgroundColor: Colors.transparent,
            onClosing: () {},
            builder: (context) {
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.5),
                      topRight: Radius.circular(12.5),
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                          onPressed: () {
                            helper.updateRegister(registerUndone[index]);
                            _setDone(registerUndone, index);
                            Navigator.pop(context);
                            registerUndone.removeAt(index);
                            _filterRegister();
                          },
                          child: Text(
                            'Atendimento concluído',
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
                            _showRegisterPage(register: registerUndone[index]);
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
      setState(() {});
      _filterRegister();
    }
  }

  void _filterRegister() {
    register = [];
    registerUndone = [];
    registerToday = [];
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

          if (dateTimeTab.difference(now).inDays == 0 &&
              dateTimeTab.day == now.day) {
            registerToday.add(element);
          }
        });

        registerToday.forEach((element) {
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
      return a.hour.toLowerCase().compareTo(b.hour.toLowerCase());
    });
  }
}
