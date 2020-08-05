import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salao/helpers/register_helper.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  final Register register;

  RegisterPage({this.register});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _atendController = TextEditingController();
  final _dateController = TextEditingController();
  final _hourController = TextEditingController();
  final _valueController = TextEditingController();

  bool _userEdited = false;

  Register _editedRegister;

  @override
  void initState() {
    super.initState();
    if (widget.register == null) {
      _editedRegister = Register();
    } else {
      _editedRegister = Register.fromMap(widget.register.toMap());

      _nameController.text = _editedRegister.name;
      _atendController.text = _editedRegister.atend;
      _dateController.text = _editedRegister.date;
      _hourController.text = _editedRegister.hour;
      _valueController.text = _editedRegister.value;
      // ignore: unnecessary_statements
      _editedRegister.date == '0';
    }
  }

  DateTime _datetime = DateTime.now();

  _selectDateRegister(BuildContext context) async {
    var _pickedDate = await showDatePicker(
      context: context,
      initialDate: _datetime,
      firstDate: DateTime(2020),
      lastDate: DateTime(2023),
    );

    if (_pickedDate != null) {
      setState(() {
        _datetime = _pickedDate;
        _dateController.text =
            DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY, 'pt_br')
                .format(_pickedDate);
        _editedRegister.date =
            DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY, 'pt_br')
                .format(_pickedDate);
      });
    }
  }

  _selectHourRegister(BuildContext context) async {
    var _pickedHour = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 08, minute: 00));

    if (_pickedHour != null) {
      setState(() {
        _hourController.text = _pickedHour.format(context);
        _editedRegister.hour = _pickedHour.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(_editedRegister.name ?? 'Novo Agendamento'),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_checkEmpty1() &&
                  _checkEmpty2() &&
                  _checkEmpty3() &&
                  _checkEmpty4() &&
                  _checkEmpty5() == true) {
                Navigator.pop(context, _editedRegister);
              } else {}
            },
            child: Icon(Icons.save),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 160.0,
                  height: 160.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 6.5,
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("images/person-male.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration:
                      InputDecoration(labelText: 'Cliente:', hintText: 'Nome'),
                  onChanged: (text) {
                    setState(() {
                      _userEdited = true;
                      _editedRegister.name = text;
                    });
                  },
                ),
                TextField(
                  controller: _atendController,
                  decoration: InputDecoration(labelText: 'Atendimento:'),
                  onChanged: (text) {
                    _userEdited = true;
                    _editedRegister.atend = text;
                  },
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        onTap: () {},
                        controller: _dateController,
                        decoration: InputDecoration(
                            labelText: 'Data:',
                            prefixIcon: InkWell(
                              onTap: () {
                                _selectDateRegister(context);

                                _userEdited = true;
                              },
                              child: Icon(Icons.calendar_today),
                            )),
                      ),
                    ),
                    Flexible(
                        child: TextField(
                      controller: _hourController,
                      decoration: InputDecoration(
                          labelText: 'Hora:',
                          prefixIcon: InkWell(
                            onTap: () {
                              _selectHourRegister(context);
                              _userEdited = true;
                            },
                            child: Icon(Icons.access_time),
                          )),
                    ))
                  ],
                ),
                TextField(
                  controller: _valueController,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(labelText: 'Valor:'),
                  onChanged: (text) {
                    _userEdited = true;
                    _editedRegister.value = text;
                  },
                ),
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Descartar Alterações?'),
              content: Text('Se sair as alterações serão perdidas.'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar')),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Sim'))
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  bool _checkEmpty1() {
    if (_editedRegister.name != null && _editedRegister.name.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool _checkEmpty2() {
    if (_editedRegister.atend != null && _editedRegister.atend.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool _checkEmpty3() {
    if (_editedRegister.date != null && _editedRegister.date.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool _checkEmpty4() {
    if (_editedRegister.date != null && _editedRegister.date.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool _checkEmpty5() {
    if (_editedRegister.value != null && _editedRegister.value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
//
