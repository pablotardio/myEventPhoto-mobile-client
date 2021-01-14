import 'dart:async';

class RegisterBloc {
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();
  final _celularController = StreamController<String>.broadcast();
  final _nombreController = StreamController<String>.broadcast();
//Recuperar los datos del stream
Stream<String> get emailStream=> _emailController.stream;
Stream<String> get passwordStream=> _passwordController.stream;
Stream<String> get celularStream=> _celularController.stream;
Stream<String> get nombreStream=> _nombreController.stream;
  //Insertar valores del Stream
Function(String) get changeEmail=>_emailController.sink.add;
Function(String) get changePassword=>_passwordController.sink.add;
Function(String) get changeCelular=>_celularController.sink.add;
Function(String) get changenNombre=>_nombreController.sink.add;

dispose(){
  _emailController?.close();
  _passwordController?.close();
  _celularController?.close();
  _nombreController?.close();
}

}

