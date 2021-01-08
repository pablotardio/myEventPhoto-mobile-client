import 'dart:convert';
import 'dart:io';


import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:myeventphoto_mobile_client/src/shared_prefs/preferencias_usuarios.dart';
class FotoProvider {
  final prefs=new PreferenciasUsuario();
  //final _url='192.168.1.4:3002';
  Future<String> subirImagen(File imagen) async{
      final url =new Uri.http('192.168.1.4:3002','/api/user/subir/foto');
      final mimeType=mime(imagen.path).split('/'); //image/jpeg
      Map<String, String> headers = { "authorization": 'bearer '+prefs.token };
      final imageUploadRequest= http.MultipartRequest(
        'POST',url,
      );
      imageUploadRequest.headers.addAll(headers);
      final file= await http.MultipartFile.fromPath(
        'foto', imagen.path,contentType: MediaType(mimeType[0], mimeType[1]) );

        imageUploadRequest.files.add(file);
        final streamResponse= await imageUploadRequest.send();
        final resp= await http.Response.fromStream(streamResponse);
        if(resp.statusCode!=200 && resp.statusCode !=201){
          print('algo salio mal');
          print(resp.body);
          return null;
        }

        final respData =json.decode(resp.body);
        return respData;

  }
}