import 'package:flutter/material.dart';
class ComprasPage extends StatefulWidget {
  ComprasPage({Key key}) : super(key: key);

  @override
  _ComprasPageState createState() => _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Escanear Evento'),
        ),
        body:Container(
            padding: EdgeInsets.all(30.0),
            child: Center(
                child: Column(children: [
           
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _botonCarrito(),
                  SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              _botonGuardar(),
            ]
            )
            )
            )
            );
  
  }
  _botonCarrito() {
    return (FloatingActionButton.extended(
      label:Text('Hola'),
      icon: Icon(Icons.qr_code) ,
      onPressed: _escanearQR,
    ));
  }


  _escanearQR() async {
    
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
        
      },
    ));
  }


  @override
  void dispose() {
    super.dispose();
    
  }
}