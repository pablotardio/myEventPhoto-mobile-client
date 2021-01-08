import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdloadPhotosPage extends StatefulWidget {
  UpdloadPhotosPage({Key key}) : super(key: key);

  @override
  _UpdloadPhotosPageState createState() => _UpdloadPhotosPageState();
}

class _UpdloadPhotosPageState extends State<UpdloadPhotosPage> {
  File foto;
  final imagePicker = new ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Subir Fotos'),
          backgroundColor: Colors.amber[900],
        ),
        body: Container(
            padding: EdgeInsets.all(30.0),
            child: Center(
                child: Column(children: [
              _mostrarFoto(),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _botonDeSubirFotos(),
                  SizedBox(
                    width: 20.0,
                  ),
                  _botonDeTomarFotos()
                ],
              )
            ]))));
  }

  Widget _botonDeSubirFotos() {
    return (FloatingActionButton(
      child: Icon(Icons.image),
      onPressed: _subirFoto,
    ));
  }

  Widget _botonDeTomarFotos() {
    return (FloatingActionButton(
      heroTag: 'unq1',
      child: Icon(Icons.camera_alt),
      onPressed: _tomarFoto,
    ));
  }

  _subirFoto() async {
    //Se guarda la imagen en un picked File
    PickedFile pickedFoto =
        await imagePicker.getImage(source: ImageSource.gallery);
    foto = File(pickedFoto.path);
    if (foto != null) {
      //limpieza
    }
    setState(() {});
  }

  _tomarFoto() async {
    //Se guarda la imagen en un picked File
    PickedFile pickedFoto =
        await imagePicker.getImage(source: ImageSource.camera);
    foto = File(pickedFoto.path);
    if (foto != null) {
      //limpieza
    }
    setState(() {});
  }

  _mostrarFoto() {
    return Image(
      image: AssetImage(foto?.path ?? 'assets/no-image.png'),
      height: 300.0,
      fit: BoxFit.cover,
    );
  }
}
