import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myeventphoto_mobile_client/src/bloc/provider.dart';
import 'package:myeventphoto_mobile_client/src/providers/menu_provider.dart';
import 'package:myeventphoto_mobile_client/src/providers/usuario_provider.dart';
import 'package:myeventphoto_mobile_client/src/shared_prefs/preferencias_usuarios.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final prefs = new PreferenciasUsuario();
  String _email;
  String _password;
  String _nombre;
  String _celular;
  UsuarioProvider _usuarioProvider = new UsuarioProvider();
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
                'Registrar',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              )
            ],
          ),
        )
      ],
    );
  }

  _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    final spacing = 0.0;
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
              Text('Registrarse'),
              SizedBox(
                height: spacing,
              ),
              _crearNombre(bloc),
              SizedBox(
                height: spacing,
              ),
              _crearCelular(bloc),
              SizedBox(
                height: spacing,
              ),
              _crearEmail(bloc),
              SizedBox(
                height: spacing,
              ),
              _crearPassword(bloc),
              SizedBox(
                height: spacing,
              ),
              _crearBoton(bloc)
            ],
          ),
        ),
      ]),
    );
  }

  _crearNombre(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.nombreStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              icon: Icon(
                Icons.text_fields,
                color: Colors.amber[900],
              ),
              hintText: 'Pepe Torrez',
              labelText: 'Nombre',
              counterText: snapshot.data,
            ),
            onChanged: (value) {
              _nombre = value;
              bloc.changenNombre(value);
            }, //sirve poner solo bloc.changeEmail porque toma el primer parametro
          ),
        );
      },
    );
  }

  _crearCelular(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.celularStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              icon: Icon(
                Icons.phone_android,
                color: Colors.amber[900],
              ),
              hintText: '77.....',
              labelText: 'Celular',
              counterText: snapshot.data,
            ),
            onChanged: (value) {
              _celular = value;
              bloc.changeCelular(value);
            }, //sirve poner solo bloc.changeEmail porque toma el primer parametro
          ),
        );
      },
    );
  }

  _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Colors.amber[900],
              ),
              hintText: 'ejemplo@mail.com',
              labelText: 'Correo Electronico ',
              counterText: snapshot.data,
            ),
            onChanged: (value) {
              _email = value;
              bloc.changeEmail(value);
            }, //sirve poner solo bloc.changeEmail porque toma el primer parametro
          ),
        );
      },
    );
  }

  _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.amber[900],
                  ),
                  counterText: snapshot.data,
                  labelText: 'Contraseña '),
              onChanged: (value) {
                _password = value;
                bloc.changePassword(value);
              },
            ),
          ),
        );
      },
    );
  }

  _crearBoton(LoginBloc bloc) {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Registrarse'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.amber[800],
        textColor: Colors.white,
        onPressed: () async {
          final res = await _usuarioProvider.register(_nombre,_celular,_email, _password,);
          prefs.token = res['token'];

          final vistas = {'vistas': res['vistas']};
          prefs.vistas = json.encode(vistas);

          // MenuProvider menuProvider= new MenuProvider();
          // final hola =await menuProvider.cargarData();

          if (prefs.token != '') {
            Navigator.pushNamed(context, 'home');
          }
        });
  }
}
