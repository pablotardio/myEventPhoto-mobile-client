import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider {
  final url = '';
  Future<Map<String,dynamic>> nuevoUsuario(String email, String password) async {
    final authdata = {
      'email': email,
      'password': password,
      'rolId': 3,
      'returnSecureToken': true
    };
    final response = await http.post(url, body: json.encode(authdata));
    Map<String, dynamic> decodedResp = json.decode(response.body);
    print(decodedResp);
    if (decodedResp.containsKey('token')) {
      return {
        'ok': true,
        'token': decodedResp['token'],
        'vistas': decodedResp['vistas']
      };
    }else{
      return {
        'ok':false
      };
    }
  }
}
