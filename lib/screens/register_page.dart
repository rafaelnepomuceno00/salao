import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salao/helpers/register_helper.dart';



class RegisterPage extends StatefulWidget {
  //contrutor com parametro opcional para editar ou criar um novo contato

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
  final _doneController = TextEditingController();

  bool _userEdited = false;

  Register _editedRegister;

  @override
  void initState() {
    super.initState();

    //vendo se um registro já existe e se não existir
    if (widget.register == null) {
      _editedRegister = Register();
    } else {
      //aqui o contato é tranformado em mapa e criado um nov contato em formato de mapa

      _editedRegister = Register.fromMap(widget.register.toMap());

      _nameController.text = _editedRegister.name;
      _atendController.text = _editedRegister.atend;
      _dateController.text = _editedRegister.date;
      _hourController.text = _editedRegister.hour;
      _valueController.text = _editedRegister.value;
      _doneController.text = _editedRegister.done;
    }

    _setDone();
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
            DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_br').format(_pickedDate);
        //  DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY, 'pt_br')
        //    .format(_pickedDate).;
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
              } else {
                _requestSave();
              }
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
                        readOnly: true,
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
                      readOnly: true,
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
                  keyboardType: TextInputType.number,
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

  Future<bool> _requestSave() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Campos Vazios!',
                textAlign: TextAlign.center,
              ),
              content: Text(
                'Ainda há campos vazios, os preencha para poder salvar',
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Center(
                  child: FlatButton(
                      color: Colors.grey[100],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'ok',
                        style: TextStyle(color: Colors.pinkAccent),
                      )),
                )
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

  void _setDone() {
    _doneController.text = '0';
    _editedRegister.done = '0';
  }
}
//
