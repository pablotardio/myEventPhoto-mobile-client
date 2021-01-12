import 'package:flutter/material.dart';
import 'package:myeventphoto_mobile_client/src/providers/foto_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class CarritoDeComprasPage extends StatefulWidget {
  CarritoDeComprasPage({Key key}) : super(key: key);

  @override
  _CarritoDeComprasPageState createState() => _CarritoDeComprasPageState();
}

class _CarritoDeComprasPageState extends State<CarritoDeComprasPage> {
  final fotoProvider = new FotoProvider();
  var fotos;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Carrito'),
        backgroundColor: Colors.amber[900],
        leading: Icon(Icons.attach_money),
      ),
      body: _menuLista(),
      endDrawer: Drawer(child: _totalCarrito()),
    );
  }

  Widget _menuLista() {
    return FutureBuilder(
      future: fotoProvider.getCarrito(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        fotos = snapshot.data;
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
      myItems.add(Container(
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
      icon: Icon(Icons.remove_red_eye),
      label: Text('Ver'),
      textColor: Colors.orange[900],
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: () {
        print('ADDED');
      },
    ));
  }

  _totalCarrito() {
    return FutureBuilder(
      future: fotoProvider.getCarrito(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        fotos = snapshot.data;
        return ListView(
          //snapshot.data es lo que me devuelve mi promise/future
          children: _listCarritoItems(context, snapshot.data),
        );
      },
    );
  }

  List<Widget> _listCarritoItems(BuildContext context, List<dynamic> data) {
    final List<Widget> myItems = [];
    //myItems.add(_fotoDePerfil());
    myItems.add(SizedBox(
      height: 10.0,
    ));
    _tituloEndDrawer(myItems);
    var counter = 1;
    var total = 0;
    data.forEach((element) {
      myItems.add(ListTile(
        title: Text('Foto $counter'),
        subtitle: Text('precio: ${element['precio']}bs'),
        leading: FadeInImage(
          placeholder: AssetImage('assets/loading-bits.gif'),
          fit: BoxFit.cover,
          image:
              NetworkImage(fotoProvider.getUrlConMarcaDeAgua(element['url'])),
        ),
      ));
      myItems.add(Divider(
        color: Colors.black,
      ));
      counter++;
      total += element['precio'];
    });
    myItems.add(Center(
        child: Text(
      'Total: $total',
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
    )));
    myItems.add(_botonPagar(total));
    return myItems;
  }

  void _tituloEndDrawer(List<Widget> myItems) {
    myItems.add(Center(
        child: Text(
      'Pago de Carrito',
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    )));
  }
  _botonPagar(total) {
    return (RaisedButton.icon(
      icon: Icon(Icons.credit_card),
      label: Text('Pagar'),
      textColor: Colors.white,
      color: Colors.orange[600],
      elevation: 4,
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: total==0?null:() {
         Navigator.pushNamed(context, '/invitado/pago/fotos');
      },
    ));
  }
}
