import 'dart:convert';

import 'package:flutter/services.dart'
    show rootBundle;
import 'package:myeventphoto_mobile_client/src/shared_prefs/preferencias_usuarios.dart'; //ese root bundle tiene lo necesario para leer ese json

class MenuProvider {
  List<dynamic> opciones = [];
  final prefs= new PreferenciasUsuario();
  MenuProvider() {
    cargarData();
  }
  Future<List<dynamic>> cargarData() async {
    Map dataMap =await json.decode(prefs.vistas);
    opciones = dataMap['vistas'];
    return opciones;
  }
}

MenuProvider menuProvider = new MenuProvider();
