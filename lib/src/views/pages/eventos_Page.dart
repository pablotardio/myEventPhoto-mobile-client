import 'package:flutter/material.dart';
import 'package:myeventphoto_mobile_client/src/providers/evento_provider.dart';

class EventosPage extends StatefulWidget {
  EventosPage({Key key}) : super(key: key);

  @override
  _EventosPageState createState() => _EventosPageState();
}


class _EventosPageState extends State<EventosPage> {
  final eventoProvider = new EventoProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Event Photo'),
        backgroundColor: Colors.amber[900],
      ),
      body: _menuLista(),
    );
  }

  Widget _menuLista() {
    return FutureBuilder(
      future: eventoProvider.getMyEventos(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView(
          //snapshot.data es lo que me devuelve mi promise/future
              children: _listMenuItems(context, snapshot.data),
            );
      },
    );
  }

  List<Widget> _listMenuItems(BuildContext context, List<dynamic> data) {
    final List<Widget> myItems = [];
    myItems.add(_fotoDePerfil());  
    myItems.add(Center(child: Text('Username'),));
        data.forEach((element) {
          myItems.add(ListTile(
            title: Text(element['nombre']),
            subtitle: Text('Esto es un item del menu'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
             
            },
          ));
        });
        return myItems;
      }
    
      Widget _fotoDePerfil() {
        return Icon(Icons.person,size: 140.0,color: Colors.deepOrange[600],);
      }
}
