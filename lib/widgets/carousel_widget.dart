import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../resources/assets_manager.dart';

class SwiperWidget extends StatefulWidget {
  const SwiperWidget({super.key});

  @override
  State<SwiperWidget> createState() => _SwiperWidgetState();
}

class _SwiperWidgetState extends State<SwiperWidget> {
  @override
  Widget build(BuildContext context) {

    final List<String> carouselImages = [
      ImagesAssets.c1,
      ImagesAssets.c2,
      ImagesAssets.c3,
      ImagesAssets.c4,
      ImagesAssets.c5,
      ImagesAssets.c6,
      ImagesAssets.c7,
      ImagesAssets.c8,
    ];

    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.asset(
          carouselImages[index],
          fit: BoxFit.fill,
        );
      },
      autoplay: true,
      itemCount: carouselImages.length,
      pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
              activeColor: Colors.cyan,
              color: Colors.blueGrey.withOpacity(0.5))),
    );
  }
}
