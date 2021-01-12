import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myeventphoto_mobile_client/src/shared_prefs/preferencias_usuarios.dart';

final prefs = new PreferenciasUsuario();

class PagoProvider {
  List<dynamic> responseFotos = [];

  final _headers = {
    "Content-Type": "application/json",
    "Authorization": 'bearer ' + prefs.token
  };
  final _host = '192.168.1.4:3002';
  Future<String> pagar({number, expMonth, expYear, cvc}) async {
    Map<String, int> body = {
      'number': number,
      'expMonth': expMonth,
      'expYear': expYear,
      'cvc': cvc
    };
    final apiUrl = '/api/invitado/carrito/pagar';
    return (await _procesarPeticion(apiUrl, body))['id'];
  }

  Future<Map<String, dynamic>> procesoLuegoPago({transactionId}) async {
    Map<String, String> body = {
      'transactionId': transactionId,
      
    };
    final apiUrl = '/api/invitado/carrito/comprar';
    return await _procesarPeticion(apiUrl, body);
  }

  Future<Map<String, dynamic>> _procesarPeticion(
      String apiUrl, Map<String, dynamic> body) async {
    final url = new Uri.http(_host, apiUrl);
    final response =
        await http.post(url, headers: _headers, body: json.encode(body));
    Map<String, dynamic> decodedResp = json.decode(response.body);
    return decodedResp;
  }
}
