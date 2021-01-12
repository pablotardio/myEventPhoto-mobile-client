import 'package:flutter/material.dart';

class ComprasPage extends StatefulWidget {
  ComprasPage({Key key}) : super(key: key);

  @override
  _ComprasPageState createState() => _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Compras'),
        ),
        body: Container(
            padding: EdgeInsets.all(30.0),
            child: Center(
                child: ListView(children: [
              _menuItemCarrito(),
              SizedBox(
                height: 25.0,
              ),
              _menuItemComprados()
            ]))));
  }

  _menuItemCarrito() {
    return ListTile(
      leading: Icon(Icons.shopping_cart),
      title: Text('Mi carrito'),
      subtitle: Text('Aqui puede ver todas sus fotos y pagarlas'),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
         Navigator.pushNamed(context, '/invitado/carrito/fotos');
        //redirecciono
      },
    );
  }

  _escanearQR() async {}

  _menuItemComprados() {
    return ListTile(
      leading: Icon(Icons.photo_album),
      title: Text('Fotos Compradas'),
      subtitle: Text('Ver y descargar todas sus fotos compradas'),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.pushNamed(context, '/invitado/compras/fotos');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
