import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:salao/screens/home_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      
      title: 'Salão Marina',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.yellow[500],
        accentColor: Colors.yellow[400],
      ),
      debugShowCheckedModeBanner: false,

      home: HomePage(),
    );
  }
}
