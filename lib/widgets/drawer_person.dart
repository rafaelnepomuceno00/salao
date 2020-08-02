import 'package:flutter/material.dart';
import 'package:salao/screens/calendar.dart';
import 'package:salao/screens/home_page.dart';

class DrawerPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(5),
                child: Text('Logo que carla fizer')),
          ],
        ),
        ListTile(
          title: Text('Tela Inicial'),
          leading: Icon(
            Icons.home,
            color: Color.fromARGB(120, 120, 120, 120),
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
          color: Color.fromARGB(120, 120, 120, 120),
          endIndent: 10,
          indent: 10,
        ),
        ListTile(
            title: Text('Calendário'),
            leading: Icon(
              Icons.calendar_today,
              color: Color.fromARGB(120, 120, 120, 120),
            ),
            onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Calendario()),
                  );
            }),
        Divider(
          color: Color.fromARGB(120, 120, 120, 120),
          endIndent: 10,
          indent: 10,
        ),
        ListTile(
            title: Text('Histórico'),
            leading: Icon(
              Icons.history,
              color: Color.fromARGB(120, 120, 120, 120),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Calendario()),
              );
            }),
        Divider(
          color: Color.fromARGB(120, 120, 120, 120),
          endIndent: 10,
          indent: 10,
        ),
        ListTile(
            title: Text('Financeiro'),
            leading: Icon(
              Icons.monetization_on,
              color: Color.fromARGB(120, 120, 120, 120),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Calendario()),
              );
            }),
        Divider(
          color: Color.fromARGB(120, 120, 120, 120),
          endIndent: 10,
          indent: 10,
        ),

      ],
    ));
  }
}
