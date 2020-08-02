import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salao/screens/register_page.dart';
import 'package:salao/widgets/drawer_person.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          'https://static.vakinha.com.br/uploads/vakinha/image/324910/1_21_180207032723_adesivo-de-parede-salao-de-beleza-07.png?ims=700x410',
          width: 100,
          height: 100,
        ),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        elevation: 0.2,
      ),
      drawer: DrawerPerson(),
      body: Container(
        color: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterPage()),
          );
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
