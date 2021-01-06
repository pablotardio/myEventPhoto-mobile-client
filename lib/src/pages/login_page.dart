import 'package:flutter/material.dart';
import 'package:myeventphoto_mobile_client/src/bloc/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [_crearFondo(context), _loginForm(context)],
    ));
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoNaranja = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(241, 39, 17, 1.0),
        Color.fromRGBO(245, 175, 25, 1.0)
      ])),
    );
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );
    return Stack(
      children: [
        fondoNaranja,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: 30.0, left: 200.0, child: circulo),
        Positioned(top: -20.0, left: -10.0, child: circulo),
        Positioned(top: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              Icon(
                Icons.person_pin,
                color: Colors.white,
                size: 80.0,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                'Iniciar Sesion',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              )
            ],
          ),
        )
      ],
    );
  }

  _loginForm(BuildContext context) {
   
     final bloc= Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(children: [
        //SafeArea se encarga de ver el espacio adicional de dispositivos, como el notch de iphones
        SafeArea(
            child: Container(
          height: 180.0,
        )),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    spreadRadius: 3.0,
                    offset: Offset(0.0, 4.0))
              ]),
          width: size.width * 0.85,
          margin: EdgeInsets.symmetric(vertical: 30.0),
          padding: EdgeInsets.symmetric(vertical: 50.0),
          child: Column(
            children: [
              Text('Ingreso'),
              SizedBox(height: 10.0,),
              _crearEmail(bloc),
              SizedBox(height: 10.0,),
              _crearPassword(bloc),
              SizedBox(height: 10.0,),
              _crearBoton()
            ],
          ),
        ),
      ]),
    );
  }

  _crearEmail(LoginBloc bloc) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: TextField(
      
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            icon: Icon(
          Icons.alternate_email,
          color: Colors.amber[900],
        ),
        hintText: 'ejemplo@mail.com',
        labelText: 'Correo Electronico '
        ),
      ),
    );
  }
  _crearPassword(LoginBloc bloc) {
    return Container(
      
      padding: EdgeInsets.all(15.0),
      child: TextField(
        obscureText: true,
        
        decoration: InputDecoration(
            icon: Icon(
          Icons.lock,
          color: Colors.amber[900],
        ),
        
        labelText: 'Contraseña '
        ),
      ),
    );
  }
  _crearBoton(){
    return RaisedButton(
      
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 80.0,
          vertical: 15.0),
        child: Text('Iniciar Sesion'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        
        ),
        color: Colors.amber[800],
        textColor: Colors.white ,
      onPressed: (){});
  }
}
