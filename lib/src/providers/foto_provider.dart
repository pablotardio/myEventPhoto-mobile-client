import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:myeventphoto_mobile_client/src/shared_prefs/preferencias_usuarios.dart';

class FotoProvider {
  /**
   * usa cloudinary para poner marca de agua
   */
  String getUrlConMarcaDeAgua(String url) {
    String watermark =
        'b_rgb:000000,c_limit,e_blur:1,h_200,o_90,w_200/ar_1:1,b_rgb:000000,c_lfill,co_rgb:ffffff,l_text:arial_80:®,o_60,r_max';
    List urlList = url.split('/');
   // print(urlList);
   // urlList.forEach((i) => print(i));
    String finalString = 'https:/';

    for (int i = 2; i < urlList.length; i++) {
      finalString = finalString + '/' + urlList[i];
      if (i == 5) {
        finalString = finalString + '/' + watermark;
      }
    }
    return finalString;
  }

  List<dynamic> responseFotos = [];
  final prefs = new PreferenciasUsuario();
  final _host = '192.168.1.4:3002';

  Future<List<dynamic>> getFotosPerfil() async {
    try {
      final url = new Uri.http(_host, '/api/user/ver/fotoperfil');
      final headers = {
        "Content-Type": "application/json",
        "authorization": 'bearer ' + prefs.token
      };
      final response = await http.get(url, headers: headers);
      Map<String, dynamic> decodedResp = json.decode(response.body);
      //print(decodedResp);

      responseFotos = decodedResp['fotos'];
      print(responseFotos);
      return responseFotos;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> subirImagen(File imagen) async {
    final url = new Uri.http(_host, '/api/user/subir/foto');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg
    Map<String, String> headers = {"authorization": 'bearer ' + prefs.token};
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url,
    );
    imageUploadRequest.headers.addAll(headers);
    final file = await http.MultipartFile.fromPath('foto', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return {'estado': 'bad'};
    }

    final respData = json.decode(resp.body);
    return respData;
  }

  Future<List<dynamic>> getFotosAllEventos() async {
    try {
      final url = new Uri.http(_host, '/api/user/ver/fotoevento');
      final headers = {
        "Content-Type": "application/json",
        "authorization": 'bearer ' + prefs.token
      };
      final response = await http.get(url, headers: headers);
      Map<String, dynamic> decodedResp = json.decode(response.body);
      //print(decodedResp);

      responseFotos = decodedResp['fotos'];
      print(responseFotos);
      return responseFotos;
    } catch (e) {
      print(e);
    }
  }
}
