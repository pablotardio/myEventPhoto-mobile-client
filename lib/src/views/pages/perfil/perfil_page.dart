import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:myeventphoto_mobile_client/src/providers/foto_provider.dart';
import 'package:myeventphoto_mobile_client/src/views/widgets/card_swiper_widget.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final fotoProvider = new FotoProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Event Photo'),
        backgroundColor: Colors.amber[900],
      ),
      body: Column(
        children: [Text('UserName'), _swiperTarjetas(), _botonSubirFoto()],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        backgroundColor: Colors.orange[900],
        tooltip: 'Pulse para subir sus fotos de perfil',
        onPressed: () {
          Navigator.pushNamed(context, '/cliente/subir/foto');
        },
      ),
    );
  }

  Widget _botonSubirFoto() {
    return (RaisedButton(
        child: Text('Subir Foto'), onPressed: _seleccionarFoto));
  }

  _swiperTarjetas() {
    return FutureBuilder(
      future: fotoProvider.getFotos(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        //Sin la condicion del length cuando el arreglo retornaba [] daba error
        if (snapshot.hasData && (snapshot.data).length > 0) {
          // print(snapshot.data);
          // print('hola');

          return CardSwiper(fotosDePerfil: snapshot.data);
        }
        return Container(
          height: 400,
          child: Center(child: Text('No hay fotos de perfil')),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 10.0)]),
        );
      },
    );
  }

  _seleccionarFoto() async {}
}
