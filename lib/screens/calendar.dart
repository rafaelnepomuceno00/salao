import 'package:flutter/material.dart';
import 'package:salao/widgets/drawer_person.dart';


class Calendario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendário',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      drawer: DrawerPerson(),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}