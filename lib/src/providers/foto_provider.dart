import 'dart:convert';
import 'dart:html';

import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
class FotoProvider {


  Future<String> subirImagen(File imagen) async{
      final url =Uri.parse('URL');
      final mimeType=mime(imagen.relativePath).split('/'); //image/jpeg

      final imageUploadRequest= http.MultipartRequest(
        'POST',url
      );

      final file= await http.MultipartFile.fromPath(
        'file', imagen.relativePath,contentType: MediaType(mimeType[0], mimeType[1]) );

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