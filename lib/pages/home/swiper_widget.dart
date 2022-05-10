import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperPage extends StatelessWidget {
  final List<String> images = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
    'assets/images/slider1.png',
    'assets/images/slider1.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.65,
      child: Swiper(
        autoplay: true,
        itemHeight: 10,
        itemBuilder: (BuildContext context, int index) {
          return new Image.asset(
            images[index],
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        pagination: new SwiperPagination(),
      ),
    );
  }
}
