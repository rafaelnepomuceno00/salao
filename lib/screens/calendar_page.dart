import 'package:flutter/material.dart';
import 'package:salao/widgets/drawer_person.dart';
import 'package:table_calendar/table_calendar.dart';


class Calendario extends StatelessWidget {
  final _calendarController = CalendarController();
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
        child: Center(
          child: TableCalendar(
            calendarController: _calendarController,
            locale: ('pt''br'),


          ),
        ),
        color: Colors.white,
      ),
    );
  }
}