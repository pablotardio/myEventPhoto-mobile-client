import 'package:shared_preferences/shared_preferences.dart';

//Patron Singleton para preferencias de usuario, es como si 
//se tuviera una sola instancia de objeto de manera estatica con datos dinamicos
class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia= new PreferenciasUsuario._internal();
  factory PreferenciasUsuario(){
    return _instancia;
  }
  PreferenciasUsuario._internal();
  SharedPreferences prefs;
  initPrefs() async{
    prefs= await SharedPreferences.getInstance();
  }
  //NINGUNA DE ESTAS PROPIEDADES SE USA
  String _token;
  int _genero;
  get genero{
    return prefs.getString('token') ?? 'nothing';
  }
  set genero(String value){
     prefs.setString('token', value);
  }
}