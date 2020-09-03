import 'package:flutter/material.dart';
import 'package:salao/screens/allregister_page.dart';
import 'package:salao/screens/financial_page.dart';
import 'package:salao/screens/historic_page.dart';
import 'package:salao/screens/home_page.dart';

class DrawerPerson extends StatelessWidget {
  Widget _buildDrawerBack() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow[400], Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer (
        child: Stack(
      children: [
        _buildDrawerBack(),
        ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                'Tela Inicial',
                style: TextStyle(
                  color: Color.fromARGB(255, 60, 60, 60),
                ),
              ),
              leading: Icon(
                Icons.home,
                color: Color.fromARGB(255, 60, 60, 60),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            Divider(
              color: Color.fromARGB(255, 60, 60, 60),
              endIndent: 10,
              indent: 10,
            ),
            ListTile(
                title: Text(
                  'Agendamentos',
                  style: TextStyle(
                    color: Color.fromARGB(255, 60, 60, 60),
                  ),
                ),
                leading: Icon(
                  Icons.import_contacts,
                  color: Color.fromARGB(255, 60, 60, 60),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AllRegister()),
                  );
                }),
            Divider(
              color: Color.fromARGB(255, 60, 60, 60),
              endIndent: 10,
              indent: 10,
            ),
            ListTile(
                title: Text(
                  'Atendimentos Concluídos',
                  style: TextStyle(
                    color: Color.fromARGB(255, 60, 60, 60),
                  ),
                ),
                leading: Icon(
                  Icons.history,
                  color: Color.fromARGB(255, 60, 60, 60),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Historic()),
                  );
                }),
            Divider(
              color: Color.fromARGB(255, 60, 60, 60),
              endIndent: 10,
              indent: 10,
            ),
            ListTile(
                title: Text(
                  'Financeiro',
                  style: TextStyle(
                    color: Color.fromARGB(255, 60, 60, 60),
                  ),
                ),
                leading: Icon(
                  Icons.monetization_on,
                  color: Color.fromARGB(255, 60, 60, 60),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Financial()),
                  );
                }),
            Divider(
              color: Color.fromARGB(255, 60, 60, 60),
              endIndent: 10,
              indent: 10,
            ),
          ],
        ),
      ],
    ));
  }
}
