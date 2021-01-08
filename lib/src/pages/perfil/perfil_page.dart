import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Event Photo'),
        backgroundColor: Colors.amber[900],
      ),
      body: Column(
        children: [Text('UserName'), _botonSubirFoto()],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        backgroundColor: Colors.orange[900],
        tooltip:'Pulse para subir sus fotos de perfil' ,
        onPressed: (){
          Navigator.pushNamed(context, '/cliente/subir/foto');
        },
      ),
    );
  }

  Widget _botonSubirFoto() {
    return (RaisedButton(
        child: Text('Subir Foto'), onPressed: _seleccionarFoto));
  }

  _seleccionarFoto() async {
   
  }
}
