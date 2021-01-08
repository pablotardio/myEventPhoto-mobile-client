import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myeventphoto_mobile_client/src/providers/foto_provider.dart';

class UpdloadPhotosPage extends StatefulWidget {
  UpdloadPhotosPage({Key key}) : super(key: key);

  @override
  _UpdloadPhotosPageState createState() => _UpdloadPhotosPageState();
}

class _UpdloadPhotosPageState extends State<UpdloadPhotosPage> {
  File foto;
  final imagePicker = new ImagePicker();
  final fotoProvider= new FotoProvider();
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
                  SizedBox( width: 20.0, ),
                  _botonDeTomarFotos()
                ],
              ),
               SizedBox( height: 20.0, ),
              _botonGuardar(),
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
    _procesarImagen(ImageSource.gallery);
  }

  _procesarImagen(ImageSource origen) async {
    // reemplazo al _subirFoto y _tomarFtos
//Se guarda la imagen en un picked File
    PickedFile pickedFoto = await imagePicker.getImage(source: origen);
    foto = File(pickedFoto.path);
    if (foto != null) {
      //limpieza
    }
    setState(() {});
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _mostrarFoto() {
    return Image(
      image: AssetImage(foto?.path ?? 'assets/no-image.png'),
      height: 300.0,
      fit: BoxFit.cover,
    );
  }

  _botonGuardar() {
    return (RaisedButton.icon(
      icon: Icon(Icons.save),
      label: Text('Guardar'),
      textColor: Colors.white,
      color: Colors.orange[900],
      elevation: 5,
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: () {
        fotoProvider.subirImagen(foto);
      },

      
    ));
  }
}
