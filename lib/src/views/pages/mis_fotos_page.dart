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
        title: Text('Mis Fotos en eventos'),
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
    //myItems.add(_fotoDePerfil());
    myItems.add(SizedBox(
      height: 10.0,
    ));

    data.forEach((element) {
      myItems.add(Padding(
        padding: const EdgeInsets.all(20.0),
        child: ClipRRect(
          
          borderRadius: BorderRadius.circular(40.0),
          child: Stack(
           
            children: [
              SizedBox(
                width: double.infinity,
              ),
              
               Center(
                  
                  child: FadeInImage(

                    height: 250.0,
                    placeholder: AssetImage('assets/loading-bits.gif'),
                    image: NetworkImage(
                      fotoProvider.getUrlConMarcaDeAgua(element['url']),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              
              Center(
                child: _botonCarrito(),
              )
            ],
          ),
        ),
      ));
    });
    return myItems;
  }

  Widget _fotoDePerfil() {
    return Icon(
      Icons.photo_album,
      size: 140.0,
      color: Colors.deepOrange[600],
    );
  }

  _botonCarrito() {
    return (RaisedButton.icon(
      icon: Icon(Icons.shopping_bag),
      label: Text('Añadir al carrito'),
      textColor: Colors.orange[900],
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: () {
        print('ADDED');
      },
    ));
  }
}
