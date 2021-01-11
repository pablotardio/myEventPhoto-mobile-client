import 'package:flutter/material.dart';
import 'package:myeventphoto_mobile_client/src/providers/foto_provider.dart';
import 'package:myeventphoto_mobile_client/src/providers/menu_provider.dart';

class MisFotosPage extends StatefulWidget {
  MisFotosPage({Key key}) : super(key: key);

  @override
  _MisFotosPageState createState() => _MisFotosPageState();
}

class _MisFotosPageState extends State<MisFotosPage> {
  final fotoProvider = new FotoProvider();
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
      future: fotoProvider.getFotosAllEventos(),
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
        data.forEach((element) {
          myItems.add(FadeInImage(
                placeholder: AssetImage('assets/loading-bits.gif'),
                image: NetworkImage(
                    element['url'])));
        });
        return myItems;
      }
    
      Widget _fotoDePerfil() {
        return Icon(Icons.photo_album,size: 140.0,color: Colors.deepOrange[600],);
      }
}
