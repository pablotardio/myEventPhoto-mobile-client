import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:myeventphoto_mobile_client/src/providers/foto_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:myeventphoto_mobile_client/src/providers/alert_provider.dart';

class MisComprasPage extends StatefulWidget {
  MisComprasPage({Key key}) : super(key: key);

  @override
  _MisComprasPageState createState() => _MisComprasPageState();
}

class _MisComprasPageState extends State<MisComprasPage> {
  final fotoProvider = new FotoProvider();
  bool _estaGuardando = false;
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
      future: fotoProvider.getFotosEventosComprados(),
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
                 fotoProvider.getUrlConThumbmail(element['url']) ,
                ),
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: _botonVer(element['url']),
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

  void _saveNetworkImage(String path) async {
    this.setState(() {
      _estaGuardando = true;
    });
    Permission.storage.request();
    GallerySaver.saveImage(path).then((bool success) {
      setState(() {
        print('Image is saved');
        AlertProvider.mostrarAlert(context, 'Guardado Exitoso',
            'La imagen se ha guardado exitosamente en su galeria');
        _estaGuardando = false;
      });
    });
  }

  _botonVer(url) {
    return (RaisedButton.icon(
      icon: _estaGuardando
          ? SizedBox(
              child: CircularProgressIndicator(),
              height: 15.0,
              width: 15.0,
            )
          : Icon(Icons.save_alt),
      label: Text('Guardar'),
      textColor: Colors.orange[900],
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: _estaGuardando ? null : () async => _saveNetworkImage(url),
    ));
  }
}
