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
  final _dataController = TextEditingController();
  final _horaController = TextEditingController();
  final _valorController = TextEditingController();

  bool _userEdited = false;

  Register _editedRegister;

  @override
  void initState() {
    if (widget.register == null) {
      _editedRegister = Register();
    } else {
      _editedRegister = Register.fromMap(widget.register.toMap());
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
        _dataController.text =
            DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY, 'pt_Br')
                .format(_pickedDate);
      });
    }
  }

  TimeOfDay _hour = TimeOfDay.now();

  _selectHourRegister(BuildContext context) async {
    var _pickedHour = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 08, minute: 00));

    if (_pickedHour != null) {
      setState(() {
        _hour = _pickedHour;
        _horaController.text = _pickedHour.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editedRegister.name ?? 'Novo Agendamento'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
            TextField(
              onTap: () {},
              controller: _dataController,
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
            TextField(
              controller: _horaController,
              decoration: InputDecoration(
                  labelText: 'Hora:',
                  prefixIcon: InkWell(
                    onTap: () {
                      _selectHourRegister(context);
                      _userEdited = true;
                    },
                    child: Icon(Icons.access_time),
                  )),
            ),
            TextField(
              controller: _valorController,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(labelText: 'Valor:'),
              onChanged: (text) {
                _userEdited = true;
                _editedRegister.valor = text;
              },
            ),
          ],
        ),
      ),
    );
  }
}
