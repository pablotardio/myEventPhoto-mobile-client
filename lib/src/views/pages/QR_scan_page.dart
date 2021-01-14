import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myeventphoto_mobile_client/src/models/evento_model.dart';
import 'package:myeventphoto_mobile_client/src/providers/evento_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

//import 'package:permission_handler/permission_handler.dart';
class QRScanPage extends StatefulWidget {
  QRScanPage({Key key}) : super(key: key);

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  String nombre = '';
  String direccion = '';
  final _eventoProvider = new EventoProvider();
  Evento eventoEscaneado;
  final _eventoEscaneadoStreamController = StreamController<Evento>.broadcast();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Escanear Evento'),
        ),
        body: Container(
            padding: EdgeInsets.all(30.0),
            child: Center(
                child: Column(children: [
              _eventoEscaneado(),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _botonEscaneoQR(),
                  SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              _botonGuardar(),
            ]))));
  }

  _botonEscaneoQR() {
    return (FloatingActionButton(
      child: Icon(Icons.qr_code),
      onPressed: _escanearQR,
    ));
  }

  _botonGaleriaQR() {}
  _escanearQR() async {
    await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      print(barcode);

      eventoEscaneado = await _eventoProvider.getEvento(barcode);
      print(eventoEscaneado.direccion);
      _eventoEscaneadoStreamController.sink.add(eventoEscaneado);
      setState(() {
        nombre = eventoEscaneado.nombre;
        direccion = eventoEscaneado.direccion;
      });
    }
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
        _eventoProvider.addMeAlEvento(eventoEscaneado.id);
        
      },
    ));
  }

  _eventoEscaneado() {
    final fontStyleTitulo= TextStyle(fontFamily: 'Times', fontSize: 20.0);
    final fontStyleContenido=TextStyle(fontFamily: 'Courier', fontSize: 20.0);
    
    return StreamBuilder<Evento>(
        stream: _eventoEscaneadoStreamController.stream,
        builder: (context, AsyncSnapshot<Evento> snapshot) {
          Widget widgetEventoEscaneado;
          print(snapshot.data);
          if (snapshot.hasData) {
            widgetEventoEscaneado = Container(
              child: Column(
                children: [
                  Text(
                    'Titulo del Evento',
                    style: fontStyleTitulo,
                  ),
                  Text(
                    snapshot.data.nombre,
                    style: fontStyleContenido,
                  ),
                  Text(
                    'Direccion del Evento',
                    style: fontStyleTitulo,
                  ),
                  Text(
                    snapshot.data.direccion,
                    style: fontStyleContenido,
                  ),
                ],
              ),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
               boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 2.0,blurRadius: 10.0)
              ]),
            );
          } else {
            widgetEventoEscaneado = Container(
                child: Column(
              children: [
                Text('Escanee un evento por favor'),
              ],
            ));
          }
          return widgetEventoEscaneado;
        });
  }

  @override
  void dispose() {
    super.dispose();
    _eventoEscaneadoStreamController.close();
  }
}
