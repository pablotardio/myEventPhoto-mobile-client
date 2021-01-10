
import 'package:flutter/material.dart';

import 'package:myeventphoto_mobile_client/src/views/pages/QR_scan_page.dart';
import 'package:myeventphoto_mobile_client/src/views/pages/home_page.dart';
import 'package:myeventphoto_mobile_client/src/views/pages/login_page.dart';
import 'package:myeventphoto_mobile_client/src/views/pages/perfil/perfil_page.dart';
import 'package:myeventphoto_mobile_client/src/views/pages/perfil/upload_photos_page.dart';
import 'package:myeventphoto_mobile_client/src/views/pages/register_page.dart';
Map <String, WidgetBuilder> getApplicationRoutes() {

  return <String, WidgetBuilder>{
        'home': (BuildContext context)=> HomePage(),
        'register': (BuildContext context)=> RegisterPage(),
        'login': (BuildContext context)=> LoginPage(),
        '/cliente/perfil': (BuildContext context)=> PerfilPage(),
        '/cliente/subir/foto': (BuildContext context)=> UpdloadPhotosPage(),
        '/cliente/scan': (BuildContext context)=> QRScanPage(),
        
        
      };
}