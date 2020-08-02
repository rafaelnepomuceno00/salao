import 'package:flutter/material.dart';
import 'package:salao/helpers/register_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class RegisterPage extends StatefulWidget {
  final Register register;

  RegisterPage({this.register});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _userEdited = false;

  Register _editedRegister;

  @override
  void initState() {
    if (widget.register == null) {
      _editedRegister = Register();
    } else {
      _editedRegister = Register.fromMap(widget.register.toMap());
    }
    ;

    MaterialApp(
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [Locale('pt', 'br')],
    );
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
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage("images/person-male.png"),
                    fit: BoxFit.cover),
              ),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'nome'),
              onChanged: (text) {
                setState(() {
                  _userEdited = true;
                  _editedRegister.name = text;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Atendimento:'),
              onChanged: (text) {
                _userEdited = true;
                _editedRegister.atend = text;
              },
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Data:',
                  prefixIcon: InkWell(
                    onTap: () async {
                      final data = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2018),
                        lastDate: DateTime(2021),
                        locale: Localizations.localeOf(context),
                      );
                    },
                    child: Icon(Icons.calendar_today),
                  )),
              onChanged: (text) {
                _userEdited = true;
                _editedRegister.data = text;
              },
            ),

            TextField(
              decoration: InputDecoration(labelText: 'hora:'),
              onChanged: (text) {
                _userEdited = true;
                _editedRegister.hora = text;
              },
            ),
            TextField(
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
