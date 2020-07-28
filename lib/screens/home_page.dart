import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: AppBar(
         title: Image.network('https://static.vakinha.com.br/uploads/vakinha/image/324910/1_21_180207032723_adesivo-de-parede-salao-de-beleza-07.png?ims=700x410',
         width: 100,
         height: 100,),
         backgroundColor: Colors.pinkAccent,
         centerTitle: true,
         elevation: 0.2,
         leading: Icon(Icons.playlist_add_check, color: Colors.black,),
       ),
       body: Container(
         color: Colors.white,
       ),

       
      
    );
  }
}
