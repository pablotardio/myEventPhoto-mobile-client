import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myeventphoto_mobile_client/src/models/evento_model.dart';
import 'package:myeventphoto_mobile_client/src/shared_prefs/preferencias_usuarios.dart';

final prefs = new PreferenciasUsuario();

class EventoProvider {
  final _host = '192.168.1.4:3002';
  final _headers = {
    "Content-Type": "application/json",
    "Authorization": 'bearer ' + prefs.token
  };

  Future<Evento> getEvento(String token) async {
    try {
      Map<String, String> body = {'eventToken': token};
      final apiUrl = '/api/invitado/evento/ver';
      Map<String, dynamic> decodedResp = await procesarPeticion(apiUrl, body);
      return Evento.fronJsonMap(decodedResp['evento']);
    } catch (e) {
      print(e);
    }
  }

   addMeAlEvento(int eventoId) async {
    Map<String, int> body = {'id': eventoId};
    final apiUrl = '/api/invitado/evento/add';
    return await procesarPeticion(apiUrl, body);
  }

  Future<List<Evento>> getMyEventos()async {
    try {
      final apiUrl = '/api/invitado/eventos/ver';
      final url = new Uri.http(_host, apiUrl);
      final response = await http.get(url, headers: _headers);
      Map<String, dynamic> decodedResp = json.decode(response.body);
      final eventos= Eventos.fromJsonList(decodedResp['eventos']);
      return eventos.items;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> procesarPeticion(
      String apiUrl, Map<String, dynamic> body) async {
    final url = new Uri.http(_host, apiUrl);
    final response =
        await http.post(url, headers: _headers, body: json.encode(body));
    Map<String, dynamic> decodedResp = json.decode(response.body);
    return decodedResp;
  }
}
