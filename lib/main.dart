import 'package:flutter/material.dart';
import 'package:myeventphoto_mobile_client/src/bloc/provider.dart';
import 'package:myeventphoto_mobile_client/src/pages/home_page.dart';
import 'package:myeventphoto_mobile_client/src/pages/login_page.dart';
import 'package:myeventphoto_mobile_client/src/routes/routes.dart';
import 'package:myeventphoto_mobile_client/src/shared_prefs/preferencias_usuarios.dart';

void main() async{
  //aqui se iniciaa el singleton porque tengo que tener los datos antes de cargar
  //la vista
  WidgetsFlutterBinding.ensureInitialized();
  final prefs =new PreferenciasUsuario();
  await prefs.initPrefs();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider( //InheritedWidget 
    //que se encarga de hacer que las variables "globales" del bloc sean accesibles a todos los usuarios
      child: MaterialApp(
      title: 'My EVent Photo App',
      // home: HomePage(),
      initialRoute: 'login',
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        print('Ruta llamada ${settings.name}');
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginPage());
      },
      debugShowCheckedModeBanner: false),
    );
}

}