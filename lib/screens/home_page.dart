import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salao/helpers/register_helper.dart';
import 'package:salao/screens/register_page.dart';
import 'package:salao/widgets/drawer_person.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RegisterHelper helper = RegisterHelper();

  List<Register> register = List();

  @override
  void initState() {
    helper.getAllRegisters().then((list) {
      setState(() {
        register = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('logo que carla fizer'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      drawer: DrawerPerson(),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: register.length,
        itemBuilder: (context, index) {
          return _registerCard(context, index);
        },
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

  Widget _registerCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                register[index].name ?? " ",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
              Text(
                register[index].atend ?? " ",
                style: TextStyle(
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
