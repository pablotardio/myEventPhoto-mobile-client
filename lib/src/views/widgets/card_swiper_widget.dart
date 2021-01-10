import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class CardSwiper extends StatelessWidget {
  //final List<Pelicula> peliculas;
  final List<dynamic> fotosDePerfil;
  const CardSwiper({@required this.fotosDePerfil});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(fotosDePerfil[index]['url']),
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: fotosDePerfil.length,

        layout: SwiperLayout.STACK,
        //pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
