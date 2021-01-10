import 'package:flutter/material.dart';
import 'package:myeventphoto_mobile_client/src/models/evento_model.dart';
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
        title: Text('Eventos'),
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
    myItems.add(_iconoCentral());  //Icono
    myItems.add(Center(child: Text('Lista de eventos asistidos'),));
        data.forEach((element) {
          myItems.add(ListTile(
            title: Text(element.nombre),
            subtitle: Text(element.direccion),
            trailing: Icon(Icons.house),
            onTap: () {
             
            },
          ));
        });
        return myItems;
      }
    
      Widget _iconoCentral() {
        return Icon(Icons.celebration,size: 140.0,color: Colors.deepOrange[600],);
      }
}
