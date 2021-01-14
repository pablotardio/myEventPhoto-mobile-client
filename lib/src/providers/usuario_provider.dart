import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider {
  final _url = 'localhost:3002';

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authdata = {
      'email': email,
      'password': password,
      'rolId': 3,
      'returnSecureToken': true
    };
    final response = await http.post(_url, body: json.encode(authdata));
    Map<String, dynamic> decodedResp = json.decode(response.body);
    print(decodedResp);
    if (decodedResp.containsKey('token')) {
      return {
        'ok': true,
        'token': decodedResp['token'],
        'vistas': decodedResp['vistas']
      };
    } else {
      return {'ok': false};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final authdata = {
        'email': email,
        'password': password,
        'rolId': 3,
        'returnSecureToken': true
      };
      final headers = {"Content-Type": "application/json"};

      final response = await http.post(
        new Uri.http('192.168.1.4:3002', '/api/login'),
        headers: headers,
        body: json.encode(authdata),
      );
      Map<String, dynamic> decodedResp = json.decode(response.body);
      // print(decodedResp);
      if (decodedResp.containsKey('token')) {
        return {
          'ok': true,
          'token': decodedResp['token'],
          'vistas': decodedResp['vistas']
        };
      } else {
        return {'ok': false};
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> register(String nombre,String celular,String email, String password) async {
    try {
      final authdata = {
        'nombre':nombre,
        'celular':int.parse(celular),
        'email': email,
        'password': password,
        'rolId': 3,
        'returnSecureToken': true
      };
      final headers = {"Content-Type": "application/json"};

      final response = await http.post(
        new Uri.http('192.168.1.4:3002', '/api/register'),
        headers: headers,
        body: json.encode(authdata),
      );
      Map<String, dynamic> decodedResp = json.decode(response.body);
      // print(decodedResp);
      if (decodedResp.containsKey('token')) {
        return {
          'ok': true,
          'token': decodedResp['token'],
          'vistas': decodedResp['vistas']
        };
      } else {
        return {'ok': false};
      }
    } catch (e) {
      print(e);
    }
  }
}
