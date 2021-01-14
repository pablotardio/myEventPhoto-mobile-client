import 'package:flutter/material.dart';
class AlertProvider{
   static void mostrarAlert(BuildContext context,String titulo,String descripcion) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text(titulo),
            content: Column(
              mainAxisSize: MainAxisSize
                  .min, //Para que las columnas se hagan resize dependiendo de los hijos que conteienen

              children: <Widget>[
                Text(descripcion),

                //FlutterLogo(size: 100.0)
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar')),
              FlatButton(onPressed: () =>Navigator.of(context).pop(), child: Text('Ok'))
            ],
          );
        });
  }
}

