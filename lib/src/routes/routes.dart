
import 'package:flutter/material.dart';
import 'package:myeventphoto_mobile_client/src/pages/home_page.dart';
import 'package:myeventphoto_mobile_client/src/pages/login_page.dart';
import 'package:myeventphoto_mobile_client/src/pages/register_page.dart';
Map <String, WidgetBuilder> getApplicationRoutes() {

  return <String, WidgetBuilder>{
        '/home': (BuildContext context)=> HomePage(),
        'register': (BuildContext context)=> RegisterPage(),
        'login': (BuildContext context)=> LoginPage(),

        
      };
}